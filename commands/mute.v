module commands

import vedrock.server.cmd

pub struct MuteCommand {
pub mut:
    manager &MuteManager = unsafe { nil }
}

pub fn (c MuteCommand) name() string {
    return 'mute'
}

pub fn (c MuteCommand) description() string {
    return 'Prevent a player from chatting'
}

pub fn (c MuteCommand) aliases() []string {
    return []
}

pub fn (c MuteCommand) permission() string {
    return 'essentials.mute'
}

pub fn (c MuteCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'player'
        },
    ]
}

pub fn (c MuteCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /mute <player>')!
        return
    }

    target_name := ctx.args[0]
    mut mgr := unsafe { c.manager }
    mgr.mute(target_name)

    if mut target := sender.find_player(target_name) {
        target.send_message('You have been muted')!
    }

    sender.send_message('${target_name} has been muted')!
}

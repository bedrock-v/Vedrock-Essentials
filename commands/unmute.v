module commands

import vedrock.server.cmd

pub struct UnmuteCommand {
pub mut:
    manager &MuteManager = unsafe { nil }
}

pub fn (c UnmuteCommand) name() string {
    return 'unmute'
}

pub fn (c UnmuteCommand) description() string {
    return 'Allow a muted player to chat again'
}

pub fn (c UnmuteCommand) aliases() []string {
    return []
}

pub fn (c UnmuteCommand) permission() string {
    return 'essentials.mute'
}

pub fn (c UnmuteCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'player'
        },
    ]
}

pub fn (c UnmuteCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /unmute <player>')!
        return
    }

    target_name := ctx.args[0]
    mut mgr := unsafe { c.manager }

    if !mgr.is_muted(target_name) {
        sender.send_message('${target_name} is not muted')!
        return
    }

    mgr.unmute(target_name)

    if mut target := sender.find_player(target_name) {
        target.send_message('You have been unmuted')!
    }

    sender.send_message('${target_name} has been unmuted')!
}

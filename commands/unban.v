module commands

import vedrock.server.cmd

pub struct UnbanCommand {
pub mut:
    manager &BanManager = unsafe { nil }
}

pub fn (c UnbanCommand) name() string {
    return 'unban'
}

pub fn (c UnbanCommand) description() string {
    return 'Unban a player'
}

pub fn (c UnbanCommand) aliases() []string {
    return ['pardon']
}

pub fn (c UnbanCommand) permission() string {
    return 'essentials.ban'
}

pub fn (c UnbanCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'player'
        },
    ]
}

pub fn (c UnbanCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /unban <player>')!
        return
    }

    target_name := ctx.args[0]
    mut mgr := unsafe { c.manager }

    _ = mgr.is_banned(target_name) or {
        sender.send_message('${target_name} is not banned')!
        return
    }

    mgr.unban(target_name)
    sender.send_message('${target_name} has been unbanned')!
}

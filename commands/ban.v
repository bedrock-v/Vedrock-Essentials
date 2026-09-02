module commands

import vedrock.server.cmd

pub struct BanCommand {
pub mut:
    manager &BanManager = unsafe { nil }
}

pub fn (c BanCommand) name() string {
    return 'ban'
}

pub fn (c BanCommand) description() string {
    return 'Ban a player from the server'
}

pub fn (c BanCommand) aliases() []string {
    return []
}

pub fn (c BanCommand) permission() string {
    return 'essentials.ban'
}

pub fn (c BanCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'player'
        },
        cmd.TextArgument{
            arg_name: 'reason'
            arg_optional: true
        },
    ]
}

pub fn (c BanCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /ban <player> [reason]')!
        return
    }

    target_name := ctx.args[0]
    reason := if ctx.args.len > 1 { ctx.args[1..].join(' ') } else { 'Banned from the server' }

    mut mgr := unsafe { c.manager }
    mgr.ban(target_name, reason, ctx.sender_name)

    if mut target := sender.find_player(target_name) {
        target.disconnect('Banned: ${reason}')
    }

    sender.send_message('${target_name} has been banned: ${reason}')!
}

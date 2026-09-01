module commands

import vedrock.server.cmd

pub struct KickCommand {}

pub fn (c KickCommand) name() string {
    return 'kick'
}

pub fn (c KickCommand) description() string {
    return 'Kick a player from the server'
}

pub fn (c KickCommand) aliases() []string {
    return []
}

pub fn (c KickCommand) permission() string {
    return 'essentials.kick'
}

pub fn (c KickCommand) arguments() []cmd.Argument {
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

pub fn (c KickCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /kick <player> [reason]')!
        return
    }

    target_name := ctx.args[0]
    reason := if ctx.args.len > 1 { ctx.args[1..].join(' ') } else { 'Kicked from the server' }

    mut target := sender.find_player(target_name) or {
        sender.send_message('Player "${target_name}" not found')!
        return
    }

    target.disconnect(reason)
    sender.send_message('${target_name} has been kicked: ${reason}')!
}

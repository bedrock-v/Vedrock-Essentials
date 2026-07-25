module commands

import vedrock.server.cmd

pub struct TpaCommand {
pub mut:
    manager &TpaManager = unsafe { nil }
}

pub fn (c TpaCommand) name() string {
    return 'tpa'
}

pub fn (c TpaCommand) description() string {
    return 'Request to teleport to a player'
}

pub fn (c TpaCommand) aliases() []string {
    return []
}

pub fn (c TpaCommand) permission() string {
    return ''
}

pub fn (c TpaCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'player'
        },
    ]
}

pub fn (c TpaCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /tpa <player>')!
        return
    }

    target_name := ctx.args[0]

    mut target := sender.find_player(target_name) or {
        sender.send_message('Player "${target_name}" not found')!
        return
    }

    mut mgr := unsafe { c.manager }
    mgr.add(ctx.sender_name, target_name)
    target.send_message('${ctx.sender_name} wants to teleport to you. Use /tpaccept or /tpdeny')!
    sender.send_message('Teleport request sent to ${target_name}')!
}

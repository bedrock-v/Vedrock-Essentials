module commands

import vedrock.server.cmd

pub struct TpacceptCommand {
pub mut:
    manager &TpaManager = unsafe { nil }
}

pub fn (c TpacceptCommand) name() string {
    return 'tpaccept'
}

pub fn (c TpacceptCommand) description() string {
    return 'Accept a teleport request'
}

pub fn (c TpacceptCommand) aliases() []string {
    return ['tpyes']
}

pub fn (c TpacceptCommand) permission() string {
    return ''
}

pub fn (c TpacceptCommand) arguments() []cmd.Argument {
    return []
}

pub fn (c TpacceptCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    mut mgr := unsafe { c.manager }
    req := mgr.get(ctx.sender_name) or {
        sender.send_message('No pending teleport request')!
        return
    }

    mut requester := sender.find_player(req.from) or {
        sender.send_message('${req.from} is no longer online')!
        mgr.remove(ctx.sender_name)
        return
    }

    x, y, z := sender.position()
    requester.teleport(x, y, z)
    requester.send_message('${ctx.sender_name} accepted your teleport request')!
    sender.send_message('Teleport request from ${req.from} accepted')!
    mgr.remove(ctx.sender_name)
}

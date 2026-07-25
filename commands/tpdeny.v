module commands

import vedrock.server.cmd

pub struct TpdenyCommand {
pub mut:
    manager &TpaManager = unsafe { nil }
}

pub fn (c TpdenyCommand) name() string {
    return 'tpdeny'
}

pub fn (c TpdenyCommand) description() string {
    return 'Deny a teleport request'
}

pub fn (c TpdenyCommand) aliases() []string {
    return ['tpno']
}

pub fn (c TpdenyCommand) permission() string {
    return ''
}

pub fn (c TpdenyCommand) arguments() []cmd.Argument {
    return []
}

pub fn (c TpdenyCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    mut mgr := unsafe { c.manager }
    req := mgr.get(ctx.sender_name) or {
        sender.send_message('No pending teleport request')!
        return
    }

    if mut requester := sender.find_player(req.from) {
        requester.send_message('${ctx.sender_name} denied your teleport request')!
    }

    sender.send_message('Teleport request denied')!
    mgr.remove(ctx.sender_name)
}

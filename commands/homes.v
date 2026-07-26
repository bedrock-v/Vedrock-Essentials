module commands

import vedrock.server.cmd

pub struct HomesCommand {
pub mut:
    manager &HomeManager = unsafe { nil }
}

pub fn (c HomesCommand) name() string {
    return 'homes'
}

pub fn (c HomesCommand) description() string {
    return 'List your saved homes'
}

pub fn (c HomesCommand) aliases() []string {
    return []
}

pub fn (c HomesCommand) permission() string {
    return ''
}

pub fn (c HomesCommand) arguments() []cmd.Argument {
    return []
}

pub fn (c HomesCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    mgr := unsafe { c.manager }
    names := mgr.list(ctx.sender_name)

    if names.len == 0 {
        sender.send_message('No homes saved. Use /sethome <name> to create one')!
        return
    }

    sender.send_message('Your homes: ${names.join(", ")}')!
}

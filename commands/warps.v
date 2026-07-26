module commands

import vedrock.server.cmd

pub struct WarpsCommand {
pub mut:
    manager &WarpManager = unsafe { nil }
}

pub fn (c WarpsCommand) name() string {
    return 'warps'
}

pub fn (c WarpsCommand) description() string {
    return 'List all warp points'
}

pub fn (c WarpsCommand) aliases() []string {
    return []
}

pub fn (c WarpsCommand) permission() string {
    return ''
}

pub fn (c WarpsCommand) arguments() []cmd.Argument {
    return []
}

pub fn (c WarpsCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    mgr := unsafe { c.manager }
    names := mgr.list()

    if names.len == 0 {
        sender.send_message('No warps available')!
        return
    }

    sender.send_message('Available warps: ${names.join(", ")}')!
}

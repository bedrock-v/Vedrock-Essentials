module commands

import vedrock.server.cmd

pub struct WarpCommand {
pub mut:
    manager &WarpManager = unsafe { nil }
}

pub fn (c WarpCommand) name() string {
    return 'warp'
}

pub fn (c WarpCommand) description() string {
    return 'Teleport to a warp point'
}

pub fn (c WarpCommand) aliases() []string {
    return []
}

pub fn (c WarpCommand) permission() string {
    return ''
}

pub fn (c WarpCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'name'
        },
    ]
}

pub fn (c WarpCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /warp <name>')!
        return
    }

    name := ctx.args[0]
    mgr := unsafe { c.manager }
    x, y, z := mgr.load(name) or {
        sender.send_message('Warp "${name}" not found')!
        return
    }

    sender.teleport(x, y, z)
    sender.send_message('Teleported to warp "${name}"')!
}

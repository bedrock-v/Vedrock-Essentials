module commands

import vedrock.server.cmd

pub struct SetwarpCommand {
pub mut:
    manager &WarpManager = unsafe { nil }
}

pub fn (c SetwarpCommand) name() string {
    return 'setwarp'
}

pub fn (c SetwarpCommand) description() string {
    return 'Create a warp point at your position'
}

pub fn (c SetwarpCommand) aliases() []string {
    return []
}

pub fn (c SetwarpCommand) permission() string {
    return ''
}

pub fn (c SetwarpCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'name'
        },
    ]
}

pub fn (c SetwarpCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /setwarp <name>')!
        return
    }

    name := ctx.args[0]
    x, y, z := sender.position()

    mut mgr := unsafe { c.manager }
    mgr.save(name, x, y, z)
    sender.send_message('Warp "${name}" created')!
}

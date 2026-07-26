module commands

import vedrock.server.cmd

pub struct DelwarpCommand {
pub mut:
    manager &WarpManager = unsafe { nil }
}

pub fn (c DelwarpCommand) name() string {
    return 'delwarp'
}

pub fn (c DelwarpCommand) description() string {
    return 'Delete a warp point'
}

pub fn (c DelwarpCommand) aliases() []string {
    return []
}

pub fn (c DelwarpCommand) permission() string {
    return ''
}

pub fn (c DelwarpCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'name'
        },
    ]
}

pub fn (c DelwarpCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /delwarp <name>')!
        return
    }

    name := ctx.args[0]
    mut mgr := unsafe { c.manager }
    mgr.remove(name)
    sender.send_message('Warp "${name}" deleted')!
}

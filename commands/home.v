module commands

import vedrock.server.cmd

pub struct HomeCommand {
pub mut:
    manager &HomeManager = unsafe { nil }
}

pub fn (c HomeCommand) name() string {
    return 'home'
}

pub fn (c HomeCommand) description() string {
    return 'Teleport to a saved home'
}

pub fn (c HomeCommand) aliases() []string {
    return []
}

pub fn (c HomeCommand) permission() string {
    return ''
}

pub fn (c HomeCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'name'
            arg_optional: true
        },
    ]
}

pub fn (c HomeCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    name := if ctx.args.len > 0 { ctx.args[0] } else { 'default' }

    mgr := unsafe { c.manager }
    x, y, z := mgr.load(ctx.sender_name, name) or {
        sender.send_message('Home "${name}" not found')!
        return
    }

    sender.teleport(x, y, z)
    sender.send_message('Teleported to home "${name}"')!
}

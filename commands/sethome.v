module commands

import vedrock.server.cmd

pub struct SethomeCommand {
pub mut:
    manager &HomeManager = unsafe { nil }
}

pub fn (c SethomeCommand) name() string {
    return 'sethome'
}

pub fn (c SethomeCommand) description() string {
    return 'Save your current position as a home'
}

pub fn (c SethomeCommand) aliases() []string {
    return []
}

pub fn (c SethomeCommand) permission() string {
    return ''
}

pub fn (c SethomeCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'name'
            arg_optional: true
        },
    ]
}

pub fn (c SethomeCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    name := if ctx.args.len > 0 { ctx.args[0] } else { 'default' }
    x, y, z := sender.position()

    mut mgr := unsafe { c.manager }
    mgr.save(ctx.sender_name, name, x, y, z)
    sender.send_message('Home "${name}" saved')!
}

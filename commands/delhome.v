module commands

import vedrock.server.cmd

pub struct DelhomeCommand {
pub mut:
    manager &HomeManager = unsafe { nil }
}

pub fn (c DelhomeCommand) name() string {
    return 'delhome'
}

pub fn (c DelhomeCommand) description() string {
    return 'Delete a saved home'
}

pub fn (c DelhomeCommand) aliases() []string {
    return []
}

pub fn (c DelhomeCommand) permission() string {
    return ''
}

pub fn (c DelhomeCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'name'
            arg_optional: true
        },
    ]
}

pub fn (c DelhomeCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    name := if ctx.args.len > 0 { ctx.args[0] } else { 'default' }

    mut mgr := unsafe { c.manager }
    mgr.remove(ctx.sender_name, name)
    sender.send_message('Home "${name}" deleted')!
}

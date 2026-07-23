module commands

import vedrock.server.cmd

pub struct BroadcastCommand {}

pub fn (c BroadcastCommand) name() string {
    return 'broadcast'
}

pub fn (c BroadcastCommand) description() string {
    return 'Broadcast a message to all players'
}

pub fn (c BroadcastCommand) aliases() []string {
    return ['bc']
}

pub fn (c BroadcastCommand) permission() string {
    return 'essentials.broadcast'
}

pub fn (c BroadcastCommand) arguments() []cmd.Argument {
    return [
        cmd.TextArgument{
            arg_name: 'message'
        },
    ]
}

pub fn (c BroadcastCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    if ctx.args.len == 0 {
        sender.send_message('Usage: /broadcast <message>')!
        return
    }
    sender.broadcast_message('[Broadcast] ${ctx.args.join(' ')}')
}

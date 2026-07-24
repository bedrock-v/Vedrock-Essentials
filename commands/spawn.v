module commands

import vedrock.server.cmd

pub struct SpawnCommand {}

pub fn (c SpawnCommand) name() string {
    return 'spawn'
}

pub fn (c SpawnCommand) description() string {
    return 'Teleport to the world spawn'
}

pub fn (c SpawnCommand) aliases() []string {
    return []
}

pub fn (c SpawnCommand) permission() string {
    return ''
}

pub fn (c SpawnCommand) arguments() []cmd.Argument {
    return []
}

pub fn (c SpawnCommand) execute(mut sender cmd.Sender, ctx cmd.Context) ! {
    sender.world_teleport('world')!
    sender.send_message('Teleported to spawn')!
}

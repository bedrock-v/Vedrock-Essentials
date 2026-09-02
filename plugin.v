module main

import plugins
import vedrock.server
import vedrock.server.permission
import commands

pub struct Essentials {
mut:
    tpa  &commands.TpaManager  = unsafe { nil }
    home &commands.HomeManager = unsafe { nil }
    warp &commands.WarpManager = unsafe { nil }
}

pub fn (e Essentials) meta() plugins.Meta {
    return plugins.Meta{
        name:    'Vedrock-Essentials'
        version: '0.2.0'
        authors: ['AslakOffi']
    }
}

pub fn (mut e Essentials) on_enable(mut srv server.Server) {
    e.tpa = commands.new_tpa_manager()
    e.home = commands.new_home_manager()
    e.warp = commands.new_warp_manager()

    permission.register(permission.Permission{
        name:        'essentials.setwarp'
        description: 'Allows creating warp points'
        default:     .op
    })
    permission.register(permission.Permission{
        name:        'essentials.delwarp'
        description: 'Allows deleting warp points'
        default:     .op
    })
    permission.register(permission.Permission{
        name:        'essentials.kick'
        description: 'Allows kicking players'
        default:     .op
    })

    srv.register_command(commands.SpawnCommand{})
    srv.register_command(commands.TpaCommand{ manager: e.tpa })
    srv.register_command(commands.TpacceptCommand{ manager: e.tpa })
    srv.register_command(commands.TpdenyCommand{ manager: e.tpa })
    srv.register_command(commands.SethomeCommand{ manager: e.home })
    srv.register_command(commands.HomeCommand{ manager: e.home })
    srv.register_command(commands.DelhomeCommand{ manager: e.home })
    srv.register_command(commands.HomesCommand{ manager: e.home })
    srv.register_command(commands.SetwarpCommand{ manager: e.warp })
    srv.register_command(commands.WarpCommand{ manager: e.warp })
    srv.register_command(commands.DelwarpCommand{ manager: e.warp })
    srv.register_command(commands.WarpsCommand{ manager: e.warp })
    srv.register_command(commands.KickCommand{})
}

pub fn (mut e Essentials) on_disable() {}

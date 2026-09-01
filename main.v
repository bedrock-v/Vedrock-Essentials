module main

import os
import time
import vedrock.server.conf
import vedrock.server
import vedrock.server.crash
import vedrock.server.permission
import commands

const crashdumps_dir = 'crashdumps'

fn main() {
    cfg := conf.load() or {
        eprintln('Failed to load config: ${err}')
        exit(1)
    }
    mut srv := server.new(settings: cfg) or {
        eprintln('Failed to start: ${err}')
        exit(1)
    }

    tpa := commands.new_tpa_manager()
    home := commands.new_home_manager()
    warp := commands.new_warp_manager()

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
    srv.register_command(commands.TpaCommand{ manager: tpa })
    srv.register_command(commands.TpacceptCommand{ manager: tpa })
    srv.register_command(commands.TpdenyCommand{ manager: tpa })
    srv.register_command(commands.SethomeCommand{ manager: home })
    srv.register_command(commands.HomeCommand{ manager: home })
    srv.register_command(commands.DelhomeCommand{ manager: home })
    srv.register_command(commands.HomesCommand{ manager: home })
    srv.register_command(commands.SetwarpCommand{ manager: warp })
    srv.register_command(commands.WarpCommand{ manager: warp })
    srv.register_command(commands.DelwarpCommand{ manager: warp })
    srv.register_command(commands.WarpsCommand{ manager: warp })
    srv.register_command(commands.KickCommand{})

    srv.log.info('Vedrock-Essentials loaded')

    os.signal_opt(.int, fn [mut srv] (_ os.Signal) {
        srv.stop()
        exit(0)
    }) or {}

    srv.start() or {
        srv.log.error('Server stopped: ${err}')
        if path := crash.write_dump(crashdumps_dir, time.now().unix(), 'server stopped', err.msg()) {
            srv.log.error('Wrote crash report to ${path}')
        }
        exit(1)
    }
}

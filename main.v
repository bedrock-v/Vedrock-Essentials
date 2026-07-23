module main

import os
import time
import vedrock.server.conf
import vedrock.server
import vedrock.server.crash
import plugins
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

    mut mgr := plugins.new_manager(
        &srv.hub.commands,
        srv.hub.events,
        srv.hub.scheduler,
        srv.hub,
        srv.log
    )
    mgr.register(Essentials{})
    mgr.enable_all()

    os.signal_opt(.int, fn [mut srv, mut mgr] (_ os.Signal) {
        mgr.disable_all()
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

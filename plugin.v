module main

import plugins
import commands

pub struct Essentials {
    plugins.Base
mut:
    tpa  &commands.TpaManager  = unsafe { nil }
    home &commands.HomeManager = unsafe { nil }
}

pub fn (e Essentials) meta() plugins.Meta {
    return plugins.Meta{
        name:    'Vedrock-Essentials'
        version: '0.1.0'
        authors: ['AslakOffi']
    }
}

pub fn (mut e Essentials) on_enable(mut api plugins.Api) {
    e.tpa = commands.new_tpa_manager()
    e.home = commands.new_home_manager()

    api.register_command(commands.MsgCommand{})
    api.register_command(commands.SpawnCommand{})
    api.register_command(commands.TpaCommand{ manager: e.tpa })
    api.register_command(commands.TpacceptCommand{ manager: e.tpa })
    api.register_command(commands.TpdenyCommand{ manager: e.tpa })
    api.register_command(commands.SethomeCommand{ manager: e.home })
    api.register_command(commands.HomeCommand{ manager: e.home })
    api.register_command(commands.DelhomeCommand{ manager: e.home })
    api.register_command(commands.HomesCommand{ manager: e.home })

    e.log.info('Essentials enabled')
}

pub fn (mut e Essentials) on_disable() {
    e.log.info('Essentials disabled')
}

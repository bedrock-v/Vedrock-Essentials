module vedrock_essentials

import server.plugin

pub struct Essentials {
    plugin.Base
}

pub fn (e Essentials) meta() plugin.Meta {
    return plugin.Meta{
        name:    'Essentials'
        version: '0.1.0'
        authors: ['AslakOffi']
    }
}

pub fn (mut e Essentials) on_enable(mut api plugin.Api) {
    e.log.info('Registering essential commands...')

    // TODO: register commands once the plugin API is wired
    // api.register_command(tpa_command())
    // api.register_command(spawn_command())
    // api.register_command(msg_command())

    e.log.info('Essentials enabled')
}

pub fn (mut e Essentials) on_disable() {
    e.log.info('Essentials disabled')
}

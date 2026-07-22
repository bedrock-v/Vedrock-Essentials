module vedrock_essentials

import plugins

pub struct Essentials {
    plugins.Base
}

pub fn (e Essentials) meta() plugins.Meta {
    return plugins.Meta{
        name:    'Essentials'
        version: '0.1.0'
        authors: ['AslakOffi']
    }
}

pub fn (mut e Essentials) on_enable(mut api plugins.Api) {
    e.log.info('Essentials enabled')
}

pub fn (mut e Essentials) on_disable() {
    e.log.info('Essentials disabled')
}

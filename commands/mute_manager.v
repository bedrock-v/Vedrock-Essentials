module commands

import os
import x.json2

@[heap]
pub struct MuteManager {
pub:
    path string = 'mutes.json'
}

pub fn new_mute_manager() &MuteManager {
    return &MuteManager{}
}

fn (m MuteManager) load_all() map[string]bool {
    content := os.read_file(m.path) or { return {} }
    raw := json2.decode[json2.Any](content) or { return {} }
    obj := raw.as_map()
    mut mutes := map[string]bool{}
    for name, _ in obj {
        mutes[name] = true
    }
    return mutes
}

fn (m MuteManager) save_all(mutes map[string]bool) {
    mut obj := map[string]json2.Any{}
    for name, _ in mutes {
        obj[name] = json2.Any(true)
    }
    os.write_file(m.path, json2.Any(obj).str()) or {}
}

pub fn (m MuteManager) mute(player string) {
    mut mutes := m.load_all()
    mutes[player.to_lower()] = true
    m.save_all(mutes)
}

pub fn (m MuteManager) unmute(player string) {
    mut mutes := m.load_all()
    mutes.delete(player.to_lower())
    m.save_all(mutes)
}

pub fn (m MuteManager) is_muted(player string) bool {
    mutes := m.load_all()
    return player.to_lower() in mutes
}

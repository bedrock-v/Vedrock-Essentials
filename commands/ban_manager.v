module commands

import os
import x.json2

struct BanEntry {
pub mut:
    player string
    reason string
    banned_by string
}

@[heap]
pub struct BanManager {
pub:
    path string = 'bans.json'
}

pub fn new_ban_manager() &BanManager {
    return &BanManager{}
}

fn (m BanManager) load_all() map[string]BanEntry {
    content := os.read_file(m.path) or { return {} }
    raw := json2.decode[json2.Any](content) or { return {} }
    obj := raw.as_map()
    mut bans := map[string]BanEntry{}
    for name, val in obj {
        h := val.as_map()
        bans[name] = BanEntry{
            player:    h['player'] or { json2.Any('') }.str()
            reason:    h['reason'] or { json2.Any('') }.str()
            banned_by: h['banned_by'] or { json2.Any('') }.str()
        }
    }
    return bans
}

fn (m BanManager) save_all(bans map[string]BanEntry) {
    mut obj := map[string]json2.Any{}
    for name, b in bans {
        mut entry := map[string]json2.Any{}
        entry['player'] = json2.Any(b.player)
        entry['reason'] = json2.Any(b.reason)
        entry['banned_by'] = json2.Any(b.banned_by)
        obj[name] = json2.Any(entry)
    }
    os.write_file(m.path, json2.Any(obj).str()) or {}
}

pub fn (m BanManager) ban(player string, reason string, banned_by string) {
    mut bans := m.load_all()
    bans[player.to_lower()] = BanEntry{
        player:    player
        reason:    reason
        banned_by: banned_by
    }
    m.save_all(bans)
}

pub fn (m BanManager) unban(player string) {
    mut bans := m.load_all()
    bans.delete(player.to_lower())
    m.save_all(bans)
}

pub fn (m BanManager) is_banned(player string) ?BanEntry {
    bans := m.load_all()
    return bans[player.to_lower()] or { return none }
}

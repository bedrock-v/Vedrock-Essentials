module commands

import os
import x.json2

struct HomeData {
pub mut:
    x f32
    y f32
    z f32
}

@[heap]
pub struct HomeManager {
pub:
    dir string = 'homes'
}

pub fn new_home_manager() &HomeManager {
    dir := 'homes'
    if !os.exists(dir) {
        os.mkdir(dir) or {}
    }
    return &HomeManager{ dir: dir }
}

fn (m HomeManager) load_all(player string) map[string]HomeData {
    content := os.read_file('${m.dir}/${player}.json') or { return {} }
    raw := json2.decode[json2.Any](content) or { return {} }
    obj := raw.as_map()
    mut homes := map[string]HomeData{}
    for name, val in obj {
        h := val.as_map()
        homes[name] = HomeData{
            x: f32(h['x'] or { json2.Any(0) }.f64())
            y: f32(h['y'] or { json2.Any(0) }.f64())
            z: f32(h['z'] or { json2.Any(0) }.f64())
        }
    }
    return homes
}

fn (m HomeManager) save_all(player string, homes map[string]HomeData) {
    mut obj := map[string]json2.Any{}
    for name, h in homes {
        mut entry := map[string]json2.Any{}
        entry['x'] = json2.Any(h.x)
        entry['y'] = json2.Any(h.y)
        entry['z'] = json2.Any(h.z)
        obj[name] = json2.Any(entry)
    }
    os.write_file('${m.dir}/${player}.json', json2.Any(obj).str()) or {}
}

pub fn (m HomeManager) save(player string, name string, x f32, y f32, z f32) {
    mut homes := m.load_all(player)
    homes[name] = HomeData{ x: x, y: y, z: z }
    m.save_all(player, homes)
}

pub fn (m HomeManager) load(player string, name string) ?(f32, f32, f32) {
    homes := m.load_all(player)
    home := homes[name] or { return none }
    return home.x, home.y, home.z
}

pub fn (m HomeManager) remove(player string, name string) {
    mut homes := m.load_all(player)
    homes.delete(name)
    m.save_all(player, homes)
}

pub fn (m HomeManager) list(player string) []string {
    homes := m.load_all(player)
    mut names := []string{}
    for name, _ in homes {
        names << name
    }
    return names
}

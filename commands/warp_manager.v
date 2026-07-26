module commands

import os
import x.json2

struct WarpData {
pub mut:
    x f32
    y f32
    z f32
}

@[heap]
pub struct WarpManager {
pub:
    path string = 'warps.json'
}

pub fn new_warp_manager() &WarpManager {
    return &WarpManager{}
}

fn (m WarpManager) load_all() map[string]WarpData {
    content := os.read_file(m.path) or { return {} }
    raw := json2.decode[json2.Any](content) or { return {} }
    obj := raw.as_map()
    mut warps := map[string]WarpData{}
    for name, val in obj {
        h := val.as_map()
        warps[name] = WarpData{
            x: f32(h['x'] or { json2.Any(0) }.f64())
            y: f32(h['y'] or { json2.Any(0) }.f64())
            z: f32(h['z'] or { json2.Any(0) }.f64())
        }
    }
    return warps
}

fn (m WarpManager) save_all(warps map[string]WarpData) {
    mut obj := map[string]json2.Any{}
    for name, w in warps {
        mut entry := map[string]json2.Any{}
        entry['x'] = json2.Any(w.x)
        entry['y'] = json2.Any(w.y)
        entry['z'] = json2.Any(w.z)
        obj[name] = json2.Any(entry)
    }
    os.write_file(m.path, json2.Any(obj).str()) or {}
}

pub fn (m WarpManager) save(name string, x f32, y f32, z f32) {
    mut warps := m.load_all()
    warps[name] = WarpData{ x: x, y: y, z: z }
    m.save_all(warps)
}

pub fn (m WarpManager) load(name string) ?(f32, f32, f32) {
    warps := m.load_all()
    warp := warps[name] or { return none }
    return warp.x, warp.y, warp.z
}

pub fn (m WarpManager) remove(name string) {
    mut warps := m.load_all()
    warps.delete(name)
    m.save_all(warps)
}

pub fn (m WarpManager) list() []string {
    warps := m.load_all()
    mut names := []string{}
    for name, _ in warps {
        names << name
    }
    return names
}

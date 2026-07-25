module commands

import time

pub struct TpaRequest {
pub:
    from string
    to   string
    sent time.Time
}

pub fn (r TpaRequest) is_expired() bool {
    return time.since(r.sent) > 30 * time.second
}

@[heap]
pub struct TpaManager {
pub mut:
    requests map[string]TpaRequest
}

pub fn new_tpa_manager() &TpaManager {
    return &TpaManager{}
}

pub fn (mut m TpaManager) add(from string, to string) {
    m.requests[to] = TpaRequest{
        from: from
        to:   to
        sent: time.now()
    }
}

pub fn (mut m TpaManager) get(to string) ?TpaRequest {
    req := m.requests[to] or { return none }
    if req.is_expired() {
        m.requests.delete(to)
        return none
    }
    return req
}

pub fn (mut m TpaManager) remove(to string) {
    m.requests.delete(to)
}

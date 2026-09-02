module commands

import vedrock.server.event

pub struct MuteHandler {
    event.NopHandler
pub mut:
    manager &MuteManager = unsafe { nil }
}

pub fn (mut h MuteHandler) on_player_chat(mut ctx event.Context[event.ChatData]) {
    if h.manager.is_muted(ctx.val.player.name()) {
        ctx.val.player.send_message('You are muted') or {}
        ctx.cancel()
    }
}

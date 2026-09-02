module commands

import vedrock.server.event

pub struct BanHandler {
    event.NopHandler
pub mut:
    manager &BanManager = unsafe { nil }
}

pub fn (mut h BanHandler) on_player_join(mut ctx event.Context[event.JoinData]) {
    entry := h.manager.is_banned(ctx.val.player.name()) or { return }
    ctx.val.player.disconnect('Banned: ${entry.reason}')
    ctx.cancel()
}

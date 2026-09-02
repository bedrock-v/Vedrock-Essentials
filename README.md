# Vedrock-Essentials

The essential plugin suite for Vedrock: teleportation, moderation, and server management commands.

> **Status:** Work in progress — commands are being added as the Vedrock framework API expands.

## Installation

Requires [Vedrock](https://github.com/bedrock-v/Vedrock) and [bedrock-v/plugins](https://github.com/bedrock-v/plugins).

## Commands

### Teleportation
| Command | Description |
|---------|-------------|
| `/spawn` | Teleport to the world spawn |
| `/tpa <player>` | Request to teleport to a player |
| `/tpaccept` | Accept a pending teleport request |
| `/tpdeny` | Deny a pending teleport request |

### Homes
| Command | Description |
|---------|-------------|
| `/sethome [name]` | Save your current position as a home (default: "default") |
| `/home [name]` | Teleport to a saved home |
| `/delhome [name]` | Delete a saved home |
| `/homes` | List all your saved homes |

### Warps
| Command | Description |
|---------|-------------|
| `/setwarp <name>` | Create a warp point at your position |
| `/warp <name>` | Teleport to a warp point |
| `/delwarp <name>` | Delete a warp point |
| `/warps` | List all warp points |

### Moderation
| Command | Description |
|---------|-------------|
| `/kick <player> [reason]` | Kick a player from the server |
| `/ban <player> [reason]` | Ban a player from the server |
| `/unban <player>` | Unban a player |
| `/mute <player>` | Prevent a player from chatting |
| `/unmute <player>` | Allow a muted player to chat again |

## License

[LGPL-3.0](LICENSE)

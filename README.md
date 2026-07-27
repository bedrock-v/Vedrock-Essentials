# Vedrock-Essentials

The essential plugin suite for Vedrock: teleportation, moderation, and server management commands.

> **Status:** Work in progress — commands are being added as the Vedrock framework API expands.

## Installation

Requires [Vedrock](https://github.com/bedrock-v/Vedrock03) and [bedrock-v/plugins](https://github.com/bedrock-v/plugins).

```
v install https://github.com/bedrock-v/plugins.git
```


## Commands



### Communication
| Command | Description |
|---------|-------------|

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


### Moderation (planned)
| Command | Description |
|---------|-------------|
| `/kick` | Kick a player from the server |
| `/ban` | Ban a player from the server |
| `/mute` | Prevent a player from chatting |

## License

[LGPL-3.0](LICENSE)

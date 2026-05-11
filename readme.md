# GSC Players Library for Plutonium T6 (Black Ops II)

## Overview
This library provides a clean set of helper functions for working with players in Plutonium T6 (Black Ops II) GSC.

---

## Features
- Easy iteration over all / alive / dead players
- Built-in filtering helpers (team, alive state, custom lists)
- Random player selection utilities
- Fast lookup by name or client number
- Simple stat queries (most kills / deaths)
- Lightweight and dependency-free

---

## API Reference

### Iteration API

#### `for_each_player(callback)`
Runs a callback for every player in the game.

---

#### `for_each_alive(callback)`
Runs a callback for every alive player.

---

#### `for_each_dead(callback)`
Runs a callback for every dead player.

---

#### `for_each_filtered(list, callback)`
Runs a callback for every player in a custom list.

---

### Player Access API

#### `get_all_players()`
Returns all players in the match.

---

#### `get_all_bots()`
Returns only bot players.

---

#### `get_alive_players()`
Returns all alive players.

---

#### `get_dead_players()`
Returns all dead players.

---

#### `get_players_by_team(team)`
Returns all players belonging to a specific team.

- **team**: team name (e.g. `"axis"`, `"allies"`)

---

### Random Selection API

#### `player_random()`
Returns a random player from the match.

---

#### `player_random_alive()`
Returns a random alive player.

---

#### `player_random_dead()`
Returns a random dead player.

---

#### `player_random_from_list(list)`
Returns a random player from a custom list.

---

### Lookup API

#### `player_by_clientnum(clientnum)`
Finds a player by their client number.

---

#### `player_by_name(name, allow_partial)`
Finds a player by name.

- **allow_partial**: enables substring matching

---

### Stats API

#### `player_by_kills()`
Returns the player with the most kills.

---

#### `player_by_deaths()`
Returns the player with the most deaths.

---

### Filtering API

### `filter_alive(list)`
Filters only alive players from a list.

---

#### `filter_dead(list)`
Filters only dead players from a list.

---

#### `filter_team(list, team)`
Filters players by team.

---

### Example Usage

```cpp
#include scripts\strings;
#include scripts\players;

init()
{
    // Run code for all alive players
    for_each_alive(function(player)
    {
        player iprintboldf("You are alive!");
    });

    // Get strongest players
    best_kills = player_by_kills();
    worst_deaths = player_by_deaths();

    // Random alive player
    random = player_random_alive();

    // Team filtering
    axis_players = get_players_by_team("axis");

    // Debug info
    printlnf("Alive players: %d", get_alive_players().size);
}
```
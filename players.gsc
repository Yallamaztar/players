/*
 * ==========================================================
 * GSC Players Utility Library for Plutonium T6 (Black Ops II)
 *
 * A lightweight players utility library for working with 
 * players in Plutonium t6 GSC (Black Ops II)
 * ==========================================================
 * Copyright (c) 2026 Budiworld 🍌
 * This script is part of a custom players utility library.
 *
 * Permission is granted to use, modify, and include this
 * code in both personal and public projects, provided that
 * the original copyright notice and this permission notice
 * remain intact in all copies or substantial portions of the
 * software.
 *
 * You are NOT required to open-source your entire project,
 * but you MUST retain this notice if this script is used.
 *
 * This software is provided "as is", without warranty of any
 * kind, express or implied.
 * ==========================================================
 * API Reference (refer to each function implementation for detailed documentation and usage)
 *
 * Iteration API:
 *   - for_each_player(callback)
 *   - for_each_alive(callback)
 *   - for_each_dead(callback)
 *   - for_each_filtered(list, callback)
 *
 * Player Access API:
 *   - get_all_players()
 *   - get_all_bots()
 *   - get_alive_players()
 *   - get_dead_players()
 *   - get_players_by_team(team)
 *
 * Random Selection API:
 *   - player_random()
 *   - player_random_alive()
 *   - player_random_dead()
 *   - player_random_from_list(list)
 *
 * Lookup API:
 *   - player_by_clientnum(clientnum)
 *   - player_by_name(name, allow_partial)
 *
 * Stats API:
 *   - player_by_kills()
 *   - player_by_deaths()
 *
 * Filtering API:
 *   - filter_alive(list)
 *   - filter_dead(list)
 *   - filter_team(list, team)
 * ==================================================================
 * Example Usage:
 * ```
 * #include scripts\strings;
 * #include scripts\players;
 * init()
 * {
 *     for_each_alive(function(player)
 *     {
 *         player iprintboldf("You are alive!");
 *     });
 *
 *     best = player_by_kills();
 *     random = player_random_alive();
 *
 *     team_players = get_players_by_team("axis");
 *
 *     printlnf("Alive players: %d", get_alive_players().size);
 * }
 * ``
 */

/*
 * for_each_player(callback) Runs the provided function for each player in the game
 *
 * Params:
 *   callback - The function to run for each player
 *
 * Example Usage:
 * ```
 * for_each_player(IPrintlnBold("Hello, player!"));
 * ```
 */
for_each_player(callback) {
    foreach (player in level.players) {
        player callback();
    }
}

/*
 * for_each_alive(callback) Runs the provided function for each alive player in the game
 *
 * Params:
 *   callback - The function to run for each alive player
 *
 * Example Usage:
 * ```
 * for_each_alive(IPrintlnBold("Hello, alive player!"));
 * ```
 */
for_each_alive(callback) {
    foreach (player in get_alive_players()) {
        player callback();
    }
}

/*
 * for_each_dead(callback) Runs the provided function for each dead player in the game
 *
 * Params:
 *   callback - The function to run for each dead player
 *
 * Example Usage:
 * ```
 * for_each_dead(IPrintlnBold("Hello, dead player!"));
 * ```
 */
for_each_dead(callback) {
    foreach (player in get_dead_players()) {
        player callback();
    }
}

/*
 * for_each_filtered(list, callback) Runs the provided function for each player in the given list
 *
 * Params:
 *   list - The list of players to iterate over
 *   callback - The function to run for each player
 *
 * Example Usage:
 * ```
 * for_each_filtered(get_alive_players(), IPrintlnBold("Hello, alive player!"));
 * ```
 */
for_each_filtered(list, callback) {
    foreach (player in list) {
        player callback();
    }
}

/*
 * get_all_players() Returns a list of all players
 *
 * Returns:
 *   List of all the players
 *
 * Example Usage:
 * ```
 * players = get_all_players();
 * ```
 */
get_all_players() {
    return level.players;
}

/*
 * get_all_bots() Returns a list of all bots
 *
 * Returns:
 *   List of all bots
 *
 * Example Usage:
 * ```
 * bots = get_all_bots();
 * ```
 */
get_all_bots() {
    bots = [];
    foreach (player in level.players) {
        if (player IsBot()) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

/*
 * get_alive_players() Returns a list of all alive players
 *
 * Returns:
 *   List of all alive players
 *
 * Example Usage:
 * ```
 * players = get_alive_players();
 * ```
 */
get_alive_players() {
    return filter_alive(get_all_players());
}

/*
 * get_dead_players() Returns a list of all dead players
 *
 * Returns:
 *   List of all dead players
 *
 * Example Usage:
 * ```
 * players = get_dead_players();
 * ```
 */
get_dead_players() {
    return filter_dead(get_all_players());
}

/*
 * get_players_by_team(team) Returns a list of all players on a specific team
 *
 * Params:
 *   team - The team to filter by
 *
 * Returns:
 *   List of all players on the specified team
 *
* Example Usage:
 * ```
 * axis = get_players_by_team("axis");
 * allies = get_players_by_team("allies");
 * ```
 */
get_players_by_team(team) {
    players = [];
    foreach (player in level.players) {
        if (player.team == team) {
            players[players.size] = player;
        }
    }
    return players;
}

/*
 * player_random() Returns a random player from the game
 *
 * Returns:
 *   A random player, or undefined if no players are available
 *
 * Example Usage:
 * ```
 * player = player_random();
 * ```
 */
player_random() {
    players = get_all_players();
    if (players.size == 0) {
        return undefined;
    }
    return players[randomint(players.size)];
}

/*
 * player_random_alive() Returns a random alive player from the game
 *
 * Returns:
 *   A random alive player, or undefined if no alive players are available
 *
 * Example Usage:
 * ```
 * player = player_random_alive();
 * ```
 */
player_random_alive() {
    players = get_alive_players();
    if (players.size == 0) {
        return undefined;
    }
    return players[randomint(players.size)];
}

/*
 * player_random_dead() Returns a random dead player from the game
 *
 * Returns:
 *   A random dead player, or undefined if no dead players are available
 *
 * Example Usage:
 * ```
 * player = player_random_dead();
 * ```
 */
player_random_dead() {
    players = get_dead_players();
    if (players.size == 0) {
        return undefined;
    }
    return players[randomint(players.size)];
}

/*
 * player_random_from_list(list) Returns a random player from the given list
 *
 * Params:
 *   list - The list of players to choose from
 *
 * Returns:
 *   A random player from the list, or undefined if the list is empty
 *
 * Example Usage:
 * ```
 * player = player_random_from_list(get_alive_players());
 * ```
 */
player_random_from_list(list) {
    if (list.size == 0) {
        return undefined;
    }
    return list[randomint(list.size)];
}

/*
 * player_by_clientnum(clientnum) Returns the player with the specified client number
 *
 * Params:
 *   clientnum - The client number to search for
 *
 * Returns:
 *   The player with the specified client number, or undefined if not found
 *
 * Example Usage:
 * ```
 * player = player_by_clientnum(0);
 * ```
 */
player_by_clientnum(clientnum) {
    foreach (player in level.players) {
        if (player GetEntityNumber() == int(clientnum)) {
            return player;
        }
    }
    return undefined;
}

/*
 * player_by_name(name, allow_partial) Returns the player with the specified name
 *
 * Params:
 *   name - The name to search for
 *   allow_partial - Whether to allow partial matches
 *
 * Returns:
 *   The player with the specified name, or undefined if not found
 *
 * Example Usage:
 * ```
 * player = player_by_name("John Doe");
 * ```
 */
player_by_name(name, allow_partial) {
    foreach (player in level.players) {
        if (allow_partial) {
            if (issubstr(ToLower(player.name), ToLower(name))) {
                return player;
            }
        } else {
            if (player.name == name) {
                return player;
            }
        }
    }
    return undefined;
}

/*
 * player_by_kills() Returns the player with the most kills
 *
 * Returns:
 *   The player with the most kills, or undefined if no players are available
 *
 * Example Usage:
 * ```
 * player = player_by_kills();
 * ```
 */
player_by_kills() {
    kills = undefined;
    most = undefined;

    foreach (player in level.players) {
        if (!isdefined(kills) && player.kills > 0) {
            kills = player.kills;
            most = player;
            continue;
        }

        if (player.kills > kills) {
            kills = player.kills;
            most = player;
        }
    }
    return most;
}

/*
 * player_by_deaths() Returns the player with most deaths
 *
 * Returns:
 *   The player with the most deaths, or undefined if no players are available
 *
 * Example Usage:
 * ```
 * player = player_by_deaths();
 * ```
 */
player_by_deaths() {
    deaths = undefined;
    most = undefined;

    foreach (player in level.players) {
        if (!isdefined(deaths) && player.deaths > 0) {
            deaths = player.deaths;
            most = player;
            continue;
        }

        if (player.deaths > deaths) {
            deaths = player.deaths;
            most = player;
        }
    }
    return most;
}

/*
 * filter_alive(list) Returns a list of alive players from the given list
 *
 * Params:
 *   list - The list of players to filter
 *
 * Returns:
 *   A list of alive players, or an empty list if no alive players are available
 *
 * Example Usage:
 * ```
 * alive_players = filter_alive(get_all_players());
 * ```
 */
filter_alive(list) {
    alive = [];
    foreach (player in list) {
        if (IsAlive(player)) {
            alive[alive.size] = player;
        }
    }
    return alive;
}

/*
 * filter_dead(list) Returns a list of dead players from the given list
 *
 * Params:
 *   list - The list of players to filter
 *
 * Returns:
 *   A list of dead players, or an empty list if no dead players are available
 *
 * Example Usage:
 * ```
 * dead_players = filter_dead(get_all_players());
 * ```
 */
filter_dead(list) {
    dead = [];
    foreach (player in list) {
        if (!IsAlive(player)) {
            dead[dead.size] = player;
        }
    }
    return dead;
}

/*
 * filter_team(list, team) Returns a list of players from the specified team
 *
 * Params:
 *   list - The list of players to filter
 *   team - The team to filter by
 *
 * Returns:
 *   A list of players from the specified team, or an empty list if no players are available
 *
 * Example Usage:
 * ```
 * red_team = filter_team(get_all_players(), "red");
 * ```
 */
filter_team(list, team) {
    players = [];
    foreach (player in list) {
        if (player.team == team) {
            players[players.size] = player;
        }
    }
    return players;
}
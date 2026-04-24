/// @desc Final Scorecard Math
// Deactivate everything except this UI object and the Goal
instance_deactivate_all(true);
instance_activate_object(obj_goal);
// obj_goal Create Event
is_final_goal = false; // Default is false for normal levels

// If a ghost somehow got through, destroy the newest one immediately
if (instance_number(obj_completion_screen) > 1) {
    instance_destroy();
}
// 1. FRESH SCAN (The "Receipt Check")
// We scan the map right now to get the absolute final numbers
var _temp_chests = 0;
var _temp_kills = 0;

var _key = ds_map_find_first(global.dead_enemies);
while (!is_undefined(_key)) {
    if (string_pos("chest", string_lower(_key)) != 0) {
        _temp_chests++;
    } else {
        _temp_kills++;
    }
    _key = ds_map_find_next(global.dead_enemies, _key);
}

// 2. SYNC GLOBALS
// Update the globals one last time so the Draw GUI sees the correct numbers
global.chests_found = _temp_chests;
global.enemies_killed = _temp_kills;

/// @desc Calculate Bonuses by Comparing Numbers

// 1. SURVIVOR (0 Deaths)
survivor_bonus = (global.level_deaths == 0) ? 15000 : 0;

// 2. SLAYER (Kills match or exceed Total)
// We check > 0 so you don't get a "Free" bonus in an empty room
slayer_bonus = (global.enemies_total > 0 && global.enemies_killed >= global.enemies_total) ? 10000 : 0;

// 3. EXPLORER (Chests match or exceed Total)
explorer_bonus = (global.chests_total > 0 && global.chests_found >= global.chests_total) ? 10000 : 0;

// 4. FINAL CALCULATION
// This is the static number we will show on the screen
final_score_display = global.player_score + survivor_bonus + slayer_bonus + explorer_bonus;

show_debug_message("BONUS CHECK: S:" + string(slayer_bonus) + " E:" + string(explorer_bonus) + " F:" + string(survivor_bonus));

if (slayer_bonus > 0) show_debug_message("SCORECARD: Slayer Bonus Added!");
if (explorer_bonus > 0) show_debug_message("SCORECARD: Explorer Bonus Added!");

// 4. FINAL SCORE
final_score = global.player_score + slayer_bonus + explorer_bonus + survivor_bonus;
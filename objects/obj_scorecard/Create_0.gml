/// @desc Snapshot Global Data
/// @desc Calculate and Apply Bonuses

// 1. Calculate the 'Flawless' state
// Level deaths must be exactly 0
var _is_flawless = (global.level_deaths == 0); 

// 2. Apply to the ACTUAL score bucket
if (_is_flawless) {
    global.player_score += 15000;
    show_debug_message("SCORECARD: Flawless Bonus Added!");
}

// 3. Final display snapshot
// We use this variable in the Draw GUI event
final_display_score = global.player_score;

alpha = 0;
global.paused = true;

// 1. Snapshot the data so it can't change or be reset by the controller
snap_enemies_k = global.enemies_killed;
snap_enemies_t = global.enemies_total;
snap_chests_f  = global.chests_found;
snap_chests_t  = global.chests_total;
snap_deaths    = global.level_deaths;
snap_score     = global.player_score;

// 2. Math (Protection against / 0)
enemy_perc = (snap_enemies_t > 0) ? (snap_enemies_k / snap_enemies_t) * 100 : 100;
chest_perc = (snap_chests_t > 0) ? (snap_chests_f / snap_chests_t) * 100 : 100;
flawless   = (snap_deaths < 1);

// 3. Tally Bonus & Update the Actual Global Score
bonus_total = 0;
if (enemy_perc >= 100 && snap_enemies_t > 0) bonus_total += 15000;
if (chest_perc >= 100 && snap_chests_t > 0)  bonus_total += 15000;
if (flawless)                                bonus_total += 15000;

// After calculating the flawless bonus
if (flawless) {
    global.player_score += 15000;
}
// Now snapshot it for the display
final_display_score = global.player_score;
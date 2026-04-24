/// @desc Level Initialization & Persistence Management

// --- 1. EMERGENCY REGISTRY REPAIR ---
// Ensure the persistent map exists before we try to scan it.
if (!variable_global_exists("dead_enemies") || !ds_exists(global.dead_enemies, ds_type_map)) {
    global.dead_enemies = ds_map_create();
    show_debug_message("CONTROLLER: Emergency Registry Repair - Map Recreated.");
}
global.paused = false;
// If the controller tracks player states:
if (instance_exists(obj_player)) {
    obj_player.has_won = false;
    obj_player.state = "IDLE";
}
// --- 2. NEW ROOM INITIALIZATION ---
if (global.last_room != room) {
    
    // THE FIX: Clear the "Receipts" if this is a brand new stage
    // We don't want Level 1's kills counting toward Level 2's total
    if (ds_exists(global.dead_enemies, ds_type_map)) {
        ds_map_clear(global.dead_enemies);
        show_debug_message("CONTROLLER: New Level Detected. Registry Cleared.");
    }

    // Tally Enemies & Chests for the NEW room
    global.enemies_total = instance_number(obj_enemy_parent);
    
    var _chest_id = asset_get_index("obj_chest_parent");
    global.chests_total = (_chest_id != -1) ? instance_number(_chest_id) : 0;
    
    global.level_deaths = 0;
    global.enemies_killed = 0;
    global.chests_found = 0;
}
// --- 3. PERSISTENT TALLY RECOVERY ---
global.chests_found = 0;
global.enemies_killed = 0;

// CRITICAL SAFETY CHECK: Does the map actually exist and have entries?
if (ds_exists(global.dead_enemies, ds_type_map) && !ds_map_empty(global.dead_enemies)) {
    var _key = ds_map_find_first(global.dead_enemies);
    
    // Safety check for the first key
    while (!is_undefined(_key)) {
        var _k_lower = string_lower(string(_key)); // Force to string to prevent crashes
        
        if (string_pos("chest", _k_lower) != 0) {
            global.chests_found++;
        } else {
            global.enemies_killed++;
        }
        
        _key = ds_map_find_next(global.dead_enemies, _key);
        
        // Safety break to prevent infinite hang
        if (is_undefined(_key)) break;
    }
}

// --- 4. FINALIZE ---
// Record the room we are in for the next death/restart check.
global.last_room = room;

show_debug_message("CONTROLLER: Persistence Restored.");
show_debug_message("-> Total Enems: " + string(global.enemies_total) + " | Slain: " + string(global.enemies_killed));
show_debug_message("-> Total Chests: " + string(global.chests_total) + " | Found: " + string(global.chests_found));
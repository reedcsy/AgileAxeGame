/// @desc Parent Enemy Setup & Persistence Check

/// @desc Parent Enemy Setup

is_dying = false; // Prevents double-tallying the death

// Use floor on xstart/ystart - these variables are set by the Room Editor
// and do not change even if the bat starts flying around.
my_key = room_get_name(room) + "_" + string(floor(xstart)) + "_" + string(floor(ystart));

if (variable_global_exists("dead_enemies")) {
    if (ds_exists(global.dead_enemies, ds_type_map)) {
        if (ds_map_exists(global.dead_enemies, my_key)) {
            instance_destroy();
            exit; 
        }
    }
}

// 3. CORE STATS (Defaults - Children will override these)
hp = 1; 
max_hp = hp;

// 4. VISUAL & STATE TRACKERS
flash = 0;      // For hit-flash shader
is_hit = false; // Prevents multi-hit in one frame
hit_dir = 0;    // For knockback

// 5. MOVEMENT DEFAULTS
hsp = 0;
vsp = 0;
grv = 0.3;
walk_spd = 1.5;

// Note: Child objects (obj_enemy_bat, etc.) MUST call event_inherited() 
// as the very first line in their own Create Events.
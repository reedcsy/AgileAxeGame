/// @desc Global Initialization Script

// --- 1. THE PRAGMA BOOT ---
// This tells the engine to run the 'init_game' function BEFORE the first room exists.
gml_pragma("global", "init_game()");

// --- 2. THE BOOTSTRAP FUNCTION ---
function init_game() {
    // Initialize any absolute base globals here
    global.paused = false;
    global.last_room = -1;
    global.player_score = 0;
    global.gems_collected = 0;

    // Create the persistent controller if it's missing
    // We use depth 0 because the controller itself doesn't draw anything
    if (!instance_exists(obj_game_controller)) {
        instance_create_depth(0, 0, 0, obj_game_controller);
        show_debug_message("SYSTEM: obj_game_controller bootstrapped via pragma.");
    }
}

// --- 3. GLOBAL UTILITIES (Functions) ---

/// @desc Safely spawn particles from any object
function emit_particles(_x, _y, _type, _count) {
    if (variable_global_exists("part_sys")) {
        // Ensure the system is actually a valid reference
        if (global.part_sys != -1 && global.part_sys != 0 && part_system_exists(global.part_sys)) {
            part_particles_create(global.part_sys, _x, _y, _type, _count);
        }
    }
}

/// @desc Toggle the game pause state
function scr_toggle_pause() {
    // Only toggle if we are in a playable room
    if (room == rm_title || room == rm_init) exit;

    global.paused = !global.paused;
    show_debug_message("SYSTEM: Pause toggled to " + string(global.paused));
}

/// @desc Format frames into a readable MM:SS.CC string
function scr_format_time(_frames) {
    if (_frames <= 0) return "00:00.00";
    
    var _fps = game_get_speed(gamespeed_fps);
    var _total_seconds = _frames / _fps;
    
    var _min = floor(_total_seconds / 60);
    var _sec = floor(_total_seconds % 60);
    var _cent = floor((_total_seconds * 100) % 100);
    
    // 2-digit formatting padding
    var _s_min = string_replace_all(string_format(_min, 2, 0), " ", "0");
    var _s_sec = string_replace_all(string_format(_sec, 2, 0), " ", "0");
    var _s_cent = string_replace_all(string_format(_cent, 2, 0), " ", "0");
    
    return _s_min + ":" + _s_sec + "." + _s_cent;
}

/// @desc Set up default highscores if the file is missing
function scr_initialize_highscores() {
    if (!file_exists("scores.ini")) {
        ini_open("scores.ini");
        
        for (var i = 0; i < 10; i++) {
            // Generate dummy times that get progressively higher (slower)
            var _dummy_time = (3600) + (i * 600); 
            var _dummy_points = 5000 - (i * 400);
            var _dummy_gems = 10 - i;
            
            ini_write_real("TopTen", "Time" + string(i), _dummy_time);
            ini_write_real("TopTen", "Points" + string(i), max(0, _dummy_points));
            ini_write_real("TopTen", "Gems" + string(i), max(0, _dummy_gems));
        }
        
        ini_close();
        show_debug_message("SYSTEM: Highscore INI initialized with dummy data.");
    }
}

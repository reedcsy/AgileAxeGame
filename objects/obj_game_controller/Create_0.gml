/// @desc Game Controller Setup
/// @desc Global Initialization
if (!variable_global_exists("dead_enemies")) {
    global.dead_enemies = ds_map_create();
    show_debug_message("INITIALIZATION: Permanent Registry Created.");
}
// If we are persistent, this code only runs ONCE at game start
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

final_stats_score = 0;
total_frames = 0;
// ... your other globals ...
// Change this:
// final_score = obj_game_controller.final_stats_score;

// To this:
final_score = global.player_score;
// Now we know this is the ONLY controller
persistent = true; 

// --- 1. PERSISTENCE REGISTRY (The Kill List) ---
// We check for variable existence so we never accidentally wipe the map on room change.
if (!variable_global_exists("dead_enemies")) {
    global.dead_enemies = ds_map_create();
    show_debug_message("REGISTRY: Permanent Death Map initialized.");
}

// --- 2. GLOBAL STATS & TIMERS ---
global.total_score    = 0;
global.player_score   = 0; // The HUD bucket
global.enemies_total  = 0;
global.enemies_killed = 0;
global.chests_found   = 0;
global.chests_total   = 0;
global.level_deaths   = 0;
global.gems_collected = 0;

total_frames  = 0;
room_frames   = 0;
timer_active  = false; 
global.last_room = room;

// --- 3. SYSTEM & AUDIO ---
freeze_timer = 0;
global.paused  = false;
pause_surf    = -1; 
fade_alpha    = 1; 

global.music_volume = 0.75;
global.sfx_volume   = 0.75;

scr_load_settings(); 

if (!audio_group_is_loaded(audiogroup_music)) {
    audio_group_load(audiogroup_music);
}
audio_group_set_gain(audiogroup_music, global.music_volume, 0);

// Pause Menu Setup
pause_index   = 0; 
pause_options = ["RESUME", "RESTART", "QUIT TO MENU"];

// --- 4. PARTICLE SYSTEM ENGINE ---
if (!variable_global_exists("part_sys") || !part_system_exists(global.part_sys)) {
    global.part_sys = part_system_create();
    part_system_depth(global.part_sys, -10000); // Set very high to draw above everything

    // Particle Definitions
    global.part_jump = part_type_create();
    part_type_shape(global.part_jump, pt_shape_disk); 
    part_type_size(global.part_jump, 0.1, 0.2, -0.01, 0);
    part_type_alpha3(global.part_jump, 1, 0.5, 0);
    part_type_color1(global.part_jump, c_white);
    part_type_life(global.part_jump, 20, 30);
    part_type_speed(global.part_jump, 1, 3, -0.1, 0);
    part_type_direction(global.part_jump, 0, 360, 0, 0);

    global.part_death_purple = part_type_create();
    var _p = global.part_death_purple;
    part_type_shape(_p, pt_shape_square);
    part_type_size(_p, 0.1, 0.3, -0.01, 0);
    part_type_color1(_p, $800080); // Hex Purple
    part_type_alpha2(_p, 1, 0);
    part_type_speed(_p, 2, 5, -0.1, 0);
    part_type_direction(_p, 0, 360, 0, 0);
    part_type_life(_p, 20, 40);
    
    global.part_player_death = part_type_create();
    var _pd = global.part_player_death;
    part_type_shape(_pd, pt_shape_square);
    part_type_size(_pd, 0.2, 0.5, -0.005, 0);
    part_type_color2(_pd, c_red, c_yellow); 
    part_type_alpha3(_pd, 1, 1, 0); 
    part_type_speed(_pd, 8, 15, -0.2, 0); 
    part_type_direction(_pd, 0, 360, 0, 0); 
    part_type_gravity(_pd, 0.5, 270); 
    part_type_life(_pd, 60, 90); 
    part_type_orientation(_pd, 0, 360, 10, 0, true);
}

// --- 5. CHECKPOINTS & SAVES ---
global.checkpoint_x    = -1;
global.checkpoint_y    = -1;
global.checkpoint_room = noone;

// --- 6. METHODS ---
spawn_dust = function(_x, _y, _count) {
    if (part_system_exists(global.part_sys)) {
        part_particles_create(global.part_sys, _x, _y, global.part_jump, _count);
    }
}

// --- 7. CAMPAIGN BOOT ---
// Ensure this ONLY runs in the init room to prevent infinite loops
if (room == rm_init) {
    global.campaign = init_campaign_data();
    room_goto(rm_title);
}
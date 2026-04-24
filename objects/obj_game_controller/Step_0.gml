/// @desc Executive Game Controller Logic (Refined)
/// @desc Global Game Logic
if (!instance_exists(obj_game_controller)) exit;
// Only increment the timer if:
// 1. The game isn't paused
// 2. The completion screen DOES NOT exist
if (!global.paused && !instance_exists(obj_completion_screen)) {
    total_frames++;
}
// --- 0. HIT STOP (FREEZE FRAME) ---
// This handles those juice/impact pauses (like the 50ms thud)
if (freeze_timer > 0) {
    freeze_timer--;
    exit; 
}

// --- 1. AUDIO MANAGEMENT ---
var _is_menu_room = (room == rm_title || room == rm_options || room == rm_highscores);
var _bgm = snd_title_music;

if (audio_group_is_loaded(audiogroup_music)) {
    if (_is_menu_room) {
        if (!audio_is_playing(_bgm)) {
            audio_play_sound(_bgm, 10, true);
            audio_sound_gain(_bgm, global.music_volume, 0);
        }
    } 
    else {
        if (audio_is_playing(_bgm)) {
            audio_stop_sound(_bgm);
        }
    }
}

// --- 2. PAUSE STATE CONSOLIDATION ---
// Check both the Pause Manager (Menu) and the Scorecard/Global Pause
var _is_paused = global.paused; 

if (instance_exists(obj_pause_manager)) {
    if (obj_pause_manager.pause) _is_paused = true;
}

// --- 3. ACTIVE GAMEPLAY LOGIC ---

// Only run this block if the game is NOT frozen by a Menu or Scorecard
if (!_is_paused) {
    
    // Global Game Timers
    // We only increment if timer_active is true (prevents timing in menus)
    if (variable_instance_exists(id, "timer_active") && timer_active) {
        total_frames++;
        room_frames++;
    }
    
    // Quick Restart (Standard Dev/Speedrun Key)
    if (keyboard_check_pressed(ord("R"))) {
        room_restart();
    }
}

// --- 4. GLOBAL INPUTS (Must stay outside !_is_paused) ---
// Note: ESC key functionality depends on your specific scr_toggle_pause logic
if (keyboard_check_pressed(vk_escape)) {
    scr_toggle_pause(); 
}

// --- 5. DEBUG/HOUSEKEEPING ---
// Logic that runs 100% of the time goes here
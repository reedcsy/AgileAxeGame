/// @desc Death Transition

// This is where you actually restart the level or go to Game Over
global.player_score = 0; // Optional reset
global.gems_collected = 0;

if (instance_exists(obj_game_controller)) {
    // If you use checkpoint loading
    // obj_game_controller.load_game_state(); 
}

room_restart(); // Standard arcade approach: restart the level
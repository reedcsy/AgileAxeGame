/// @desc Splash Logic - Cinematic Timing with Sound

switch(splash_state) {
    
    case 0: // --- INITIAL BLACK (1 Second) ---
        if (alarm[1] == -1) alarm[1] = 60; 
    break;

    case 1: // --- FADE IN (2 Seconds) ---
        // PLAY SOUND ONCE
        if (!played_snd) {
            var _snd = asset_get_index("snd_splash_screen");
            if (_snd != -1 && audio_exists(_snd)) {
                audio_play_sound(_snd, 10, false);
            }
            played_snd = true; // Set flag so it doesn't repeat
        }

        image_alpha += 0.008; 
        if (image_alpha >= 1) {
            image_alpha = 1;
            splash_state = 2;
        }
    break;

    case 2: // --- HOLD (2 Seconds) ---
        if (alarm[0] == -1) alarm[0] = 120; 
    break;

    case 3: // --- FADE OUT (2 Seconds) ---
        image_alpha -= 0.008;
        if (image_alpha <= 0) {
            image_alpha = 0;
            splash_state = 4;
        }
    break;

    case 4: // --- TRANSITION ---
        if (room_exists(rm_title)) room_goto(rm_title);
    break;
}

// Global Skip (also stops sound if skipped)
if (keyboard_check_pressed(vk_anykey) || gamepad_button_check_pressed(0, gp_face1)) {
    audio_stop_sound(asset_get_index("snd_splash_screen"));
    room_goto(rm_title);
}
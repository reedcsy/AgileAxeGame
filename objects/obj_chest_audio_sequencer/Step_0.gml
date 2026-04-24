/// @desc Faster Overlapping Sound Sequence

if (sounds_played < max_sounds) {
    sound_timer -= 1;
    
    if (sound_timer <= 0) {
        var _snd = asset_get_index("snd_bonus");
        
        if (_snd != -1) {
            var _inst = audio_play_sound(_snd, 10, false);
            
            // Keep the pitch climb (it sounds even better when fast!)
            var _climb = 1.0 + (sounds_played * 0.12);
            audio_sound_pitch(_inst, _climb + random_range(-0.02, 0.02));
        }
        
        sounds_played += 1;
        
        // --- SPEED TUNING ---
        // sound_delay starts at 5 frames (~0.08s)
        // We only add 4 frames each time instead of 8.
        // This keeps the "rhythm" fast while still giving that slowing feel.
        sound_delay += 4; 
        sound_timer = sound_delay;
    }
} else {
    instance_destroy();
}
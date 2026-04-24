function scr_load_settings() {
    if (file_exists("settings.ini")) {
        ini_open("settings.ini");
        
        // Read values, providing the initialized global as the default fallback
        global.music_volume = ini_read_real("Audio", "Music", 0.75);
        global.sfx_volume   = ini_read_real("Audio", "SFX", 0.75);
        
        var _full = ini_read_real("Video", "Fullscreen", 0);
        window_set_fullscreen(_full);
        
        ini_close();
        
        // Apply the loaded volume to the audio engine immediately
        audio_group_set_gain(audiogroup_default, global.sfx_volume, 0);
        // audio_group_set_gain(audiogroup_music, global.music_volume, 0); 
    }
}
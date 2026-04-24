/// @desc Initialize Options Menu
menu_options = ["FULLSCREEN", "MUSIC VOLUME", "SFX VOLUME", "CLEAR SCORES", "BACK"];
index = 0; // Which option is highlighted

// Load current settings into local variables for the UI to display
fullscreen = window_get_fullscreen();
music_vol = global.music_volume * 100; // 0-100 for display
sfx_vol = global.sfx_volume * 100;
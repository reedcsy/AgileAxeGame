function scr_save_settings() {
    ini_open("settings.ini");
    ini_write_real("Audio", "Music", global.music_volume);
    ini_write_real("Audio", "SFX", global.sfx_volume);
    ini_write_real("Video", "Fullscreen", window_get_fullscreen());
    ini_close();
}
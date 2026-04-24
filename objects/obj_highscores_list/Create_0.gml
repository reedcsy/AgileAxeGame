// 1. Load the Best Time from our INI file
ini_open("scores.ini");
// We use 0 as a default to check if a score actually exists
best_time_frames = ini_read_real("Records", "BestTime", 0); 
ini_close();

// 2. Formatting Function (The same one used in your HUD)
format_time = function(_frames) {
    if (_frames <= 0) return "--:--.--";
    
    var _fps = game_get_speed(gamespeed_fps);
    var _total_seconds = _frames / _fps;
    var _min = floor(_total_seconds / 60);
    var _sec = floor(_total_seconds % 60);
    var _cent = floor((_total_seconds * 100) % 100);
    
    var _s_min = string_replace_all(string_format(_min, 2, 0), " ", "0");
    var _s_sec = string_replace_all(string_format(_sec, 2, 0), " ", "0");
    var _s_cent = string_replace_all(string_format(_cent, 2, 0), " ", "0");
    
    return _s_min + ":" + _s_sec + "." + _s_cent;
}
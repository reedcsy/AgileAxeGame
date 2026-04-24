// 1. Fix the GUI scale so it fits the window
display_set_gui_size(window_get_width(), window_get_height());

// 2. If the file doesn't exist, create it with dummy data
if (!file_exists("scores.ini")) {
    ini_open("scores.ini");
    for (var i = 0; i < 10; i++) {
        // Create 10 empty slots with very slow times
        ini_write_real("TopTen", "Time" + string(i), 999999);
        ini_write_real("TopTen", "Points" + string(i), 0);
        ini_write_real("TopTen", "Gems" + string(i), 0);
    }
    ini_close();
}
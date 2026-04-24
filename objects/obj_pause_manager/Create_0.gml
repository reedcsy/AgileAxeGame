/// @desc Init Pause Manager
pause = false;
pause_surf = -1; // To store the frozen game frame

menu_index = 0;
menu_options = ["RESUME", "RESTART", "QUIT"];
menu_count = array_length(menu_options);

// Navigation Timing
menu_timer = 0;
menu_delay = 10;
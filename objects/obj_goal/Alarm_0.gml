if (room_exists(room_next(room))) {
    room_goto_next();
} else {
// If no more rooms, go to the menu we just built
    room_goto(rm_main_menu); 
}
if (room_exists(target_room)) {
    room_goto(target_room);
} else {
    show_debug_message("Error: Target room not assigned to " + string(episode_name));
}
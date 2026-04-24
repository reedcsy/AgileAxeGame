// Mouse Left Pressed Event
if (room_exists(target_room)) {
    room_goto(target_room);
} else {
    show_debug_message("Warning: target_room is not set for " + object_get_name(object_index));
}
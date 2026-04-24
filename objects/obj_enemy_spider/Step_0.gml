event_inherited();
/// @desc Spider AI & Parent Inheritance

switch (state) {
    case "IDLE":
        if (instance_exists(obj_player)) {
            if (distance_to_object(obj_player) < detect_range) {
                state = "DROPPING";
            }
        }
        break;

    case "DROPPING":
        // 1. Check for collision before moving
        if (!place_meeting(x, y + drop_speed, obj_wall)) {
            y += drop_speed;
            
            // Spawn web objects
            if (y - last_web_y >= spawn_web_delay) {
                instance_create_layer(x, y, "Instances", obj_web);
                last_web_y = y;
            }
        } else {
            // 2. We hit something! Move to DANGLED state
            state = "DANGLED";
        }

        // 3. Off-screen check (cleanup)
        if (y > room_height + 64) {
            instance_destroy();
        }
        break;

    case "DANGLED":
        // Optional: Small bobbing effect while stuck
        y += sin(get_timer() * 0.000005) * 0.5;
        break;
}

// --- DEATH & COLLISION LOGIC ---
// This calls enemy_parent to handle the sword collision, 
// the 50ms hit-stop, and the obj_death_effect explosion.
event_inherited();
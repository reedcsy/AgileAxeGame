event_inherited();
/// @desc Circular Flight & Death Logic

if (global.paused) exit;

// --- 1. CIRCULAR FLIGHT ---
// Movement only happens while alive
if (hp > 0) {
    flight_angle += orbit_speed; // Using the variable name from your Create event
    if (flight_angle >= 360) flight_angle -= 360;

    // Orbiting around the Anchor point (set at birth)
    x = anchor_x + lengthdir_x(orbit_radius, flight_angle);
    y = anchor_y + lengthdir_y(orbit_radius, flight_angle);

    // Dynamic Flipping based on movement direction
    var _next_x = anchor_x + lengthdir_x(orbit_radius, flight_angle + 1);
    image_xscale = (_next_x > x) ? 1 : -1;
}

// --- 2. THE COLLISION & DEATH ---
// Using place_meeting to check for the player's sword
if (place_meeting(x, y, obj_player_melee)) {
    
    // A. PERSISTENCE: Lock the kill using the 'Birth Key'
    if (variable_global_exists("dead_enemies")) {
        if (ds_exists(global.dead_enemies, ds_type_map)) {
            // Using 'my_key' ensures it matches the spawn check exactly
            ds_map_add(global.dead_enemies, my_key, true);
            show_debug_message("REGISTRY: Logged Bat Death at " + string(my_key));
        }
    }

    // B. SCORE & TALLY
    global.player_score += 500;
    global.enemies_killed++;

    // C. SOUND EFFECTS
    var _snd_hurt = asset_get_index("snd_spider_hurt");
    if (_snd_hurt != -1) audio_play_sound(_snd_hurt, 10, false);

    // D. JUICE: PARTICLES
    var _p_index = asset_get_index("obj_death_effect");
    if (_p_index != -1) {
        var _dir = (instance_exists(obj_player)) ? sign(x - obj_player.x) : 1;
        if (_dir == 0) _dir = 1;

        repeat(30) {
            var _p = instance_create_depth(x, y, -9000, _p_index);
            _p.hsp = (_dir * random_range(3, 10)); 
            _p.vsp = random_range(-10, 2); 
            
            // Set Color (Purple Ichor)
            _p.color = choose($800080, $4B0082, $EE82EE, c_fuchsia);
        }
    }

    // E. JUICE: CAMERA & HIT-STOP
    if (instance_exists(obj_camera)) {
        obj_camera.shake_remain = 10;
        obj_camera.shake_magnitude = 6;
    }

    // ARCADE HIT-STOP: No more while loops! 
    // This tells the controller to pause the game for 5 frames.
    if (instance_exists(obj_game_controller)) {
        obj_game_controller.freeze_timer = 5; 
    }

    // F. FINAL DESTRUCTION
    instance_destroy();
}
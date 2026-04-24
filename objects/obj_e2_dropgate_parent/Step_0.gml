// 1. COLLISION & TRIGGER LOGIC
if (!is_open) {
    // Check for Melee
    if (place_meeting(x, y, obj_player_melee)) {
        is_open = true;
    }

    // Check for Dagger
    var _dagger = instance_place(x, y, obj_dagger);
    if (_dagger != noone) {
        var _hit_x = _dagger.x;
        var _hit_y = _dagger.y;
        
        dagger_hits -= 1;
        instance_destroy(_dagger);
        
        // SHUDDER: Subtract from angle to kick it FORWARD (toward the ground)
        image_angle -= 8; 
        
        if (instance_exists(obj_dust_puff)) {
            instance_create_layer(_hit_x, _hit_y, "Instances", obj_dust_puff);
        }

        if (dagger_hits <= 0) is_open = true;
    }

    // RECOVERY: Pull it back UP to 90 if it's currently lower
    if (image_angle != 90) {
        image_angle = lerp(image_angle, 90, 0.15); // Slightly faster recovery
        if (abs(image_angle - 90) < 0.2) image_angle = 90;
    }
}

// 2. AGGRESSIVE ROTATION (The slam)
else if (!has_landed) {
    fall_speed += gravity_power;
    fall_speed = min(fall_speed, max_fall_speed);
    
    image_angle -= fall_speed;

    if (image_angle <= 0) {
        image_angle = 0;
        has_landed = true;
        
        // Screen Shake
        if (instance_exists(obj_camera)) {
            with (obj_camera) {
                shake_remain = 15;
                shake_magnitude = 15;
            }
        }
        
        // Dust Burst
        repeat(12) {
            var _dist = random(sprite_width);
            instance_create_layer(x + lengthdir_x(_dist, 0), y, "Instances", obj_dust_puff);
        }
    }
}
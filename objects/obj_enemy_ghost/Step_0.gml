/// @desc Ghost Enemy AI Step

// 0. Safety Check
if (!instance_exists(obj_player)) exit;

// Constant Ghostly Visuals
// This creates a subtle "flicker" and transparency
image_alpha = 0.6 + (sin(current_time * 0.005) * 0.2); 

switch (state) {
    
    case BAT_STATE.IDLE:
        sprite_index = spr_ghost_flying;
        image_speed = 0.5; 
        y += sin(current_time * 0.002) * 0.2;

        if (point_distance(x, y, obj_player.x, obj_player.y) < wake_range) {
            state = BAT_STATE.WAKING;
            wake_timer = wake_delay;
            
            if (audio_exists(snd_bat_wake)) {
                audio_play_sound(snd_bat_wake, 10, false, 1, 0, 0.8);
            }
        }
        break;

    case BAT_STATE.WAKING:
        sprite_index = spr_ghost_flying; 
        image_speed = 2.0; 
        x += random_range(-2, 2);
        y += random_range(-2, 2);
        
        wake_timer--;
        if (wake_timer <= 0) {
            state = BAT_STATE.CHASE;
        }
        break;

    case BAT_STATE.CHASE:
        sprite_index = spr_ghost_flying;
        timer += 0.05; 
        var _target_speed = base_speed;
        
        var _dir = point_direction(x, y, obj_player.x, obj_player.y);
        if (!variable_instance_exists(id, "ghost_dir")) ghost_dir = _dir;

        var _diff = angle_difference(_dir, ghost_dir);
        ghost_dir += clamp(_diff, -2, 2); 

        hsp = lengthdir_x(_target_speed, ghost_dir);
        vsp = lengthdir_y(_target_speed, ghost_dir);

        var _sway = sin(timer * 2) * 1.5;
        var _sway_dir = ghost_dir + 90;
        
        x += hsp + lengthdir_x(_sway, _sway_dir);
        y += vsp + lengthdir_y(_sway, _sway_dir);

        if (hsp != 0) image_xscale = sign(hsp);
        image_speed = 1;
        break;
}

// --- DEATH LOGIC ---
// Instead of writing the collision code again, we call the Parent's Step Event.
// The Parent handles the collision with obj_player_melee and the particle explosion.
event_inherited();
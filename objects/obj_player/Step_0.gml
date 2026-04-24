/// @desc Player Step Event - Final Polish

// 0. GLOBAL PAUSE CHECK
if (global.paused) exit;

// 1. INPUT GATHERING
var _in = scr_get_inputs(0);
var _key_left      = _in.left;
var _key_right     = _in.right;
var _key_jump      = _in.jump;
var _key_jump_held = keyboard_check(vk_space) || gamepad_button_check(0, gp_face1);
var _key_throw     = keyboard_check_pressed(vk_control) || gamepad_button_check_pressed(0, gp_face3);
var _key_melee     = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face2);

// 2. THE MASTER "FREEZE" GATE
// We check every condition that should stop the player.
if (is_dead || state == "WIN" || has_won || input_lock_timer > 0) {
    
    // Countdown the lock timer if it's active
    if (input_lock_timer > 0) input_lock_timer--;
    
    // Handle WIN/STILL logic
    if (state == "WIN" || has_won) {
        hsp = 0;
        vsp = 0;
        image_speed = 0;
    } 
    // Handle DEATH physics (falling corpse)
    else if (is_dead) {
        hsp = lerp(hsp, 0, 0.1); 
        vsp += grav; 
        if (place_meeting(x, y + vsp, obj_wall)) {
            while (!place_meeting(x, y + sign(vsp), obj_wall)) y += sign(vsp);
            vsp = 0;
        }
        y += vsp;
    }
    
    // CRITICAL: This exit prevents any of the movement code below from running.
    exit; 
}

// ---------------------------------------------------------
// EVERYTHING BELOW ONLY RUNS IF THE PLAYER IS "ACTIVE"
// ---------------------------------------------------------

var move_dir = _key_right - _key_left; 

// --- HELPER: GROUND DETECTION ---
var _gate = instance_place(x, y + 1, obj_e2_dropgate_parent);
var _gate_solid = (_gate != noone && _gate.image_angle <= 5); 
var _on_wall = place_meeting(x, y + 1, obj_wall);
var _on_ground = _on_wall || _gate_solid;

// 3. HORIZONTAL MOVEMENT
if (move_dir != 0) {
    image_xscale = move_dir; 
    if (abs(hsp) <= move_speed) {
        if (sign(move_dir) != sign(hsp) && hsp != 0) hsp += move_dir * (accel * 2); 
        hsp += move_dir * accel;
        hsp = clamp(hsp, -move_speed, move_speed);
    } else {
        hsp = lerp(hsp, move_dir * move_speed, 0.1);
    }
} else {
    var _fric_to_apply = _on_ground ? fric : air_fric;
    if (hsp != 0) {
        var _hsp_dir = sign(hsp);
        hsp -= _hsp_dir * _fric_to_apply;
        if (sign(hsp) != _hsp_dir) hsp = 0; 
    }
}

// 4. GRAVITY & MOVING PLATFORMS
var _m_plat = instance_place(x, y + vsp + 1, obj_moving_platform); 
var _is_above = false;
if (_m_plat != noone && bbox_bottom <= _m_plat.bbox_top + 5) _is_above = true;

if (_m_plat != noone && vsp >= 0 && _is_above) {
    _on_ground = true;
    vsp = 0;
    y = _m_plat.bbox_top - (bbox_bottom - y);
    x += _m_plat.hsp;
    y += _m_plat.vsp;
} else {
    vsp += grav;
}

// 5. WALL SLIDE
on_wall = place_meeting(x + 2, y, obj_wall) - place_meeting(x - 2, y, obj_wall);
if (on_wall != 0 && !_on_ground && vsp > 0) {
    if ((on_wall == 1 && _key_right) || (on_wall == -1 && _key_left)) vsp = min(vsp, 2); 
}

// 6. JUMPING
if (_on_ground) jumps_current = 0; 
if (_key_jump) {
    var _can_jump = false;
    if (on_wall != 0 && !_on_ground) {
        vsp = jump_force;
        hsp = -on_wall * (move_speed * 1.2);
        jumps_current = 1; 
        _can_jump = true;
    } else if (jumps_current < jumps_max) {
        vsp = jump_force;
        jumps_current += 1;
        _can_jump = true;
    }
    if (_can_jump && audio_exists(snd_jump)) {
        var _snd = audio_play_sound(snd_jump, 10, false);
        audio_sound_pitch(_snd, random_range(0.8, 1.2) + (jumps_current > 1 ? 0.2 : 0));
    }
}
if (vsp < 0 && !_key_jump_held) vsp = max(vsp, jump_force / 2);

// 7. COLLISION EXECUTION (H & V)
var _h_gate = instance_place(x + hsp, y, obj_e2_dropgate_parent);
if (place_meeting(x + hsp, y, obj_wall) || _h_gate != noone) {
    var _col_obj = place_meeting(x + hsp, y, obj_wall) ? obj_wall : obj_e2_dropgate_parent;
    while (!place_meeting(x + sign(hsp), y, _col_obj)) x += sign(hsp);
    hsp = 0;
}
x += hsp;

var _v_gate = instance_place(x, y + vsp, obj_e2_dropgate_parent);
var _v_gate_solid = (_v_gate != noone && _v_gate.image_angle <= 5);

if (place_meeting(x, y + vsp, obj_wall) || _v_gate_solid || (_m_plat != noone && vsp >= 0 && _is_above)) {
    if (!(_m_plat != noone && vsp >= 0 && _is_above)) {
        var _target_col = place_meeting(x, y + vsp, obj_wall) ? obj_wall : obj_e2_dropgate_parent;
        while (!place_meeting(x, y + sign(vsp), _target_col)) y += sign(vsp);
        vsp = 0;
    }
}
y += vsp;

// 8. HAZARDS & DEATH
if (inv_timer > 0) inv_timer--;
else invincible = false;

if ((place_meeting(x, y, obj_hazard_parent) || y > room_height + 100) && !is_dead) {
    is_dead = true;
    global.level_deaths += 1; 
    image_speed = 0;
    image_alpha = 0; 
    var _hurt_snd = asset_get_index("snd_player_die");
    if (_hurt_snd != -1) audio_play_sound(_hurt_snd, 10, false);
    if (variable_global_exists("part_sys")) {
        part_particles_create(global.part_sys, x, y, global.part_player_death, 50);
    }
    alarm[0] = 90; 
}

// 9. ATTACKS
if (_key_throw) {
    var _inst = instance_create_layer(x + (image_xscale * 12), y - 8, "Instances", obj_dagger);
    if (instance_exists(_inst)) {
        _inst.hsp = 15 * image_xscale; 
        _inst.vsp = -3; 
        _inst.image_xscale = image_xscale;
    }
    if (audio_exists(snd_throw)) audio_sound_pitch(audio_play_sound(snd_throw, 10, false), random_range(0.9, 1.1));
}

if (_key_melee && !instance_exists(obj_player_melee)) {
    var _m_inst = instance_create_layer(x + (image_xscale * 20), y, "Instances", obj_player_melee);
    _m_inst.image_xscale = image_xscale;
    var _m_snd = asset_get_index("snd_sword_swing");
    if (_m_snd != -1) audio_play_sound(_m_snd, 10, false);
    hsp *= 0.5;
}
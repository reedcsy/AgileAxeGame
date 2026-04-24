event_inherited();
/// @desc Heavy Patrol AI - Clean & Steady

// 1. TIMERS
if (knockback_timer > 0) knockback_timer--;
if (flash > 0) flash--;

// 2. GRAVITY
vsp += grv;

// 3. MOVEMENT & TURNING
// We only move and turn if we aren't currently being knocked back
if (knockback_timer <= 0) {
    if (hsp != 0) hsp = sign(hsp) * walk_spd;

    var _check_x = x + (sign(hsp) * 20);
    var _check_y = y + 32;
    
    var _wall_hit = place_meeting(x + hsp, y, obj_wall);
    var _edge_reached = !position_meeting(_check_x, _check_y, obj_wall);

    if (_wall_hit || _edge_reached) {
        if (_wall_hit) {
            while (!place_meeting(x + sign(hsp), y, obj_wall)) x += sign(hsp);
        }
        hsp = -sign(hsp) * walk_spd;
        x += sign(hsp) * 2;
    }
}

// 4. HORIZONTAL COLLISION
if (place_meeting(x + hsp, y, obj_wall)) {
    while (!place_meeting(x + sign(hsp), y, obj_wall)) x += sign(hsp);
    hsp = 0; 
} else {
    x += hsp;
}

// 5. VERTICAL COLLISION
if (place_meeting(x, y + vsp, obj_wall)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall)) y += sign(vsp);
    vsp = 0;
}
y += vsp;

// 6. ANIMATION & FACING
if (knockback_timer <= 0 && hsp != 0) {
    image_xscale = sign(hsp);
}

// 7. INHERITANCE (The Death & Hit Logic)
// We wrap the inheritance in a check so it only triggers the 
// parent's "Death Explosion" once the HP is actually empty.
if (hp <= 0) {
    event_inherited(); 
} else {
    // If you want the guard to bleed a LITTLE bit when hit but not die,
    // you can add a simple collision check here for obj_player_melee.
    if (place_meeting(x, y, obj_player_melee) && flash <= 0) {
        hp -= 1;
        flash = 3;
        // Add a small knockback kick here if needed
		global.enemies_killed++;
    }
}

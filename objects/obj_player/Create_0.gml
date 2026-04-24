/// @desc Initialize Player Stats
// ... (your existing stats) ...
is_dead = false; // Flag to track death
state = "IDLE"; // or whatever your default state is

// obj_player Create Event
gamepad_slot = -1; // -1 means no gamepad detected yet
// obj_player - Create Event
spawn_wall_dust = false;
spawn_double_dust = false;
is_dead = false;
has_won = false;
// ... (rest of your physics variables)
// Movement Constants
move_speed = 8;
grav = 0.3;
jump_force = -14;
accel = 0.5;
fric = 0.3;           // How fast you stop (friction)
air_fric = 0.1;       // Less friction in the air for better control

// Jump variables
jumps_max = 2;      // Total jumps allowed (1 = normal, 2 = double)
jumps_current = 0;  // How many jumps have we used?

// Variable Jump & Wall Mechanics
jump_hold_frames = 15; // How long holding jump affects height
on_wall = 0; // -1 for left, 1 for right, 0 for none

// Velocity
hsp = 0;
vsp = 0;


scr_die = function() {
	
	
	
    // Play death sound if you have one
    // audio_play_sound(snd_death, 10, false);
	
    
    // Restart the room
    room_restart();
}

// Health System
hp_max = 3;
hp = hp_max;
invincible = false; // Prevents taking 3 damage in 1 frame
inv_timer = 0;      // Countdown for I-frames

// If a checkpoint was saved in this room, move the player there immediately
if (global.checkpoint_room == room) {
    x = global.checkpoint_x;
    y = global.checkpoint_y;
}
/// @desc obj_player Create
// ... existing variables ...
input_lock_timer = 0;
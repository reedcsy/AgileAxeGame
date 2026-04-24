/// @desc Init Undead Guard

// 1. INHERITANCE
// This brings in any variables defined in obj_enemy_parent (like hp or flash)
event_inherited(); 

// 2. PHYSICS & MOVEMENT
hsp = 1.2;         // Horizontal speed (Start moving)
vsp = 0;           // Vertical speed (Must be set to 0 to start)
grv = 0.3;         // Gravity force
walk_spd = 1.2;    // The base speed he returns to after knockback

// 3. HEALTH & COMBAT
// We use 5 HP for a "Heavy" feel that takes a few axe swings
hp = 5;            
flash = 0;         // Timer for the white hit-shader

// 4. TIMERS & STATE
// This prevents the "glitchy flipping" during knockback
knockback_timer = 0; 
ledge_check_timer = 0;
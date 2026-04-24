/// @desc Initialize Orbiting Bat

// 1. INHERIT FROM PARENT
// This pulls in 'my_key' and runs the instance_destroy() check automatically.
event_inherited(); 

// 2. SAFETY CHECK
// If the parent destroyed us, stop running this script immediately.
if (!instance_exists(id)) exit;

// 3. STATS & FLIGHT SETTINGS
hp = 1; 
flight_angle = 0; 
orbit_radius = 64;   
orbit_speed  = 2;    

// 4. THE ANCHOR
// Anchoring to xstart/ystart ensures the bat circles its spawn point
anchor_x = xstart;
anchor_y = ystart;

// 5. VISUALS
sprite_index = spr_bat_fly;
image_speed = 1;

// 6. DEBUG
show_debug_message("BAT SPAWN: Key is " + string(my_key));
/// @desc Init Hitbox

// 1. VISUALS (For testing)
image_alpha = 0.5; // Semi-transparent so you can see the reach

// 2. TIMING
alarm[0] = 15;     // How many frames the "swing" stays active

// 3. DATA STRUCTURE
// CRITICAL: This must only happen ONCE. 
hit_list = ds_list_create();

alarm[0] = 5; // Lifetime of the hitbox in frames
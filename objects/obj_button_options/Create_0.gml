/// @desc obj_button_options Create Event
event_inherited(); // Keeps the hover/menu logic from the parent

// 1. Initialize Identity
// This MUST be "OPTIONS" so the Left Released event runs the correct code
menu_selection = "OPTIONS"; 

// 2. Interaction Safety
// Options should always be clickable, unlike the Continue button
can_click = true;
image_alpha = 1.0; 

// 3. Collision Mask Fix
// Forces the button to use its own sprite as the hitbox
if (mask_index == -1) mask_index = sprite_index;

show_debug_message("Options Button Initialized: menu_selection is " + menu_selection);
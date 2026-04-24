/// @desc obj_continue_button Create Event
event_inherited(); // Keeps the hover/menu logic from the parent

// 1. Initialize Menu State
// Ensure this matches exactly what the Left Pressed event checks for
menu_selection = "CONTINUE"; 

// 2. Interaction Safety
// We create this variable so the Left Pressed event knows whether to "ignore" clicks
can_click = false;

// 3. Check if a save file exists
if (file_exists("savedata.ini")) {
    image_alpha = 1.0; 
    can_click = true;
} else {
    image_alpha = 0.5; // Visual feedback: Button is disabled
    can_click = false;
}

// 4. Collision Mask Fix
// Forces the button to use its own sprite as the hitbox if the parent doesn't have one
if (mask_index == -1) mask_index = sprite_index;
/// @description Initialize Goal Variables

// --- Win State Flags ---
has_triggered_win = false;  // The "Gatekeeper" to prevent double-triggering
has_won           = false;  // General state for the level/UI logic
triggered         = false;  // Legacy/Back-up trigger flag

// --- Room Transition Logic ---
// We use 'noone' instead of -1 in modern GameMaker for clarity.
// This check allows you to set the target_room in the Room Editor's 
// "Variable Definitions" or "Creation Code" without it being overwritten.
if (!variable_instance_exists(id, "target_room")) {
    target_room = noone; 
}

// --- Debugging ---
show_debug_message("GOAL CREATED: Ready for player.");
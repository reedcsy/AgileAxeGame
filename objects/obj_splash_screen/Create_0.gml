/// @desc Initialize Splash Sequence

// 1. SEQUENCE STATE (The "Director's Script")
// State 0: Max Wraps Logo Fades In
// State 1: Max Wraps Logo Holds
// State 2: Fade Out Max Wraps
// State 3: Game Title Logo Fades In
// State 4: Game Title Logo Holds/Shines
// State 5: Exit to Title Screen
splash_state = 0;
hold_timer   = 0; // Tracks how long a logo stays on screen
logo_alpha   = 0; // Handles the fading
/// @desc Debug Init
splash_state = 1; // Start in the "Hold" state
image_alpha = 1;  // Start fully visible
played_snd = false; // The one-shot flag
alarm[0] = 180;   // 3 seconds 

// 2. TIMING SETTINGS (60fps assumed)
// How fast to fade in/out (lower is slower)
fade_speed   = 0.05; 

// How long the logo holds on screen after fading in (frames)
hold_time_studio = 120; // 2 seconds
hold_time_title  = 180; // 3 seconds

// 3. SOUND HANDLING
// We use a safe check so it doesn't crash if the sound is missing
played_studio_snd = false;
played_title_snd  = false;

show_debug_message("SPLASH: Logic initialized.");
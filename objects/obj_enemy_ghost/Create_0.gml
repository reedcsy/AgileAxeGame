event_inherited();

// Set the ghost's specific "blood" (ectoplasm) colors
// Teal, Cyan, and White for a ghostly glow
// Blue + Green in BGR format is $FFFF00
blood_color = choose($FFFF00, $E0FFFF, $AFEEEE, c_aqua);

// State Machine
enum BAT_STATE {
    IDLE,
	WAKING,
    CHASE
}
state = BAT_STATE.IDLE;

hp = 1; // Or whatever health you want the spider to have

// Detection
wake_range = 420; // Distance in pixels (roughly half a screen)

// Movement Stats
base_speed = 2;
move_speed = 0;
flap_strength = 2.5;

// Timers
timer = 0;
path_timer = 0;
path_delay = 40;
target_dir = 0;
wake_delay = 45; // About 0.75 seconds of "waking up" time
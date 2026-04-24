event_inherited();
// Stats
detect_range = 400;
drop_speed = 2;
spawn_web_delay = 70; // Create a web every 8 pixels
last_web_y = y;

// States
state = "IDLE"; 
target_y = y + 256; // How far down it should dangle
hp = 1; // Or whatever health you want the spider to have
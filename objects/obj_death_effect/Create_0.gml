// Randomize the "explosion" direction
hsp = random_range(-5, 5);
vsp = random_range(-8, -2); // Upward burst
grav = 0.35; // Gravity to pull them down
fric = 0.98; // Air resistance

size = random_range(2, 5);
alpha = 1.0;
fade_speed = random_range(0.01, 0.03);

// Different shades of Purple/Indigo for a vibrant ichor effect
// Using Hex codes for more precise "retro" colors
color = choose(
    $800080, // Classic Purple
    $4B0082, // Indigo (Deep/Dark)
    $EE82EE, // Violet (Bright/Highlight)
    c_fuchsia // Bright Magenta for arterial spray
);
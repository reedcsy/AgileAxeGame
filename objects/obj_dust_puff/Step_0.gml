// Movement
x += hsp;
y += vsp;

// Apply friction
hsp *= fric;
vsp *= fric;

// Fade out and shrink
alpha -= fade_speed;
scale -= 0.01;

// Destroy when invisible
if (alpha <= 0) instance_destroy();
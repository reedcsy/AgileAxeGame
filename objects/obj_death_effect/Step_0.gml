// Apply physics
vsp += grav;
hsp *= fric;

x += hsp;
y += vsp;

// Fade and shrink
alpha -= fade_speed;
if (alpha <= 0) instance_destroy();
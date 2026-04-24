// Apply the shake
x += random_range(-shake_remain, shake_remain);
y += random_range(-shake_remain, shake_remain);

// Reduce the shake over time
shake_remain = max(0, shake_remain - (shake_magnitude / 20)); 
// Or use a multiplier for a more organic feel:
// shake_remain *= shake_fade;
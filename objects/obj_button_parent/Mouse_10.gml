// When mouse hovers, highlight the button
image_index = 1; 

// Play a subtle "blip" sound if you have one
if (audio_exists(snd_menu_select)) {
    audio_play_sound(snd_menu_hover, 1, false);
}

// Make the button pulse quickly while hovered
image_blend = c_white; // Reset blend just in case
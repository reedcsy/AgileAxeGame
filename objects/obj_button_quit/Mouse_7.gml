// Play a subtle "blip" sound if you have one
if (audio_exists(snd_menu_select)) 
    audio_play_sound(snd_menu_select, 1, false);

// End the game
game_end();
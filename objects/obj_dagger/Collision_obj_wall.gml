// 1. Stop the movement
hsp = 0;
vsp = 0;
grav = 0;

// 2. Freeze the rotation logic
// We can do this by setting hsp to 0 (which we did above) 
// but let's also stop the image animation if your sprite has frames
image_speed = 0; 

// 3. Set the specific frame (image_index)
// In GameMaker, frames start at 0.
// Change '0' to whichever frame of your scintillating sprite you want to show
image_index = 0; 

// 4. Optional: Stop the image_angle from spinning 
// (Ensure your Step Event check 'if (hsp != 0)' as shown below)
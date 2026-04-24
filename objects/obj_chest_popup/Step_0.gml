/// @desc Handle Life and Overlapping Sound Sequence

// 1. Overall life of the popup
timer -= 1;
if (timer <= 0) {
    instance_destroy();
    exit; // Stop running code immediately if destroyed
}


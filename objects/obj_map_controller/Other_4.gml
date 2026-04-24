// Clear the array and fill it with all instances of the parent
buttons = [];
for (var i = 0; i < instance_number(obj_button_parent); i++) {
    buttons[i] = instance_find(obj_button_parent, i);
}
/// @desc Prevent Memory Leaks
// We use the generic ds_exists check
if (ds_exists(hit_list, ds_type_list)) {
    ds_list_destroy(hit_list);
}
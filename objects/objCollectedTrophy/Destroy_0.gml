if (array_length(global.collected_trophies_stack) > 0) {
	var trophy_next = global.collected_trophies_stack[0];
	collect_trophy(trophy_next);
	array_delete(global.collected_trophies_stack, 0, 1);
}

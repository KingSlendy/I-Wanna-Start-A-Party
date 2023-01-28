function block_update() {
	sprite_index = objBoard.block_sprites[block_id][global.baba_blocks[block_id]];
	x = xstart - 32 * global.baba_toggled[block_id];
}
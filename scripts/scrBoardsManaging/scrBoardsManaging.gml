function Board(name, scene, makers) constructor {
	self.name = name;
	self.scene = scene;
	self.makers = makers;
}

function board_init() {
	global.boards = [
		new Board("Island", rBoardIsland, "KingSlendy\nJPRG666"),
		new Board("Hotland", rBoardHotland, "KingSlendy\nJPRG666"),
		new Board("Baba Is Board", rBoardBaba, "KingSlendy"),
		new Board("Pallet Town", rBoardPallet, "KingSlendy"),
		new Board("Lucid Dreams", rBoardDreams, "Kogami Takara\nKingSlendy"),
		new Board("Hyrule", rBoardHyrule, "KingSlendy")
	];
}

function board_collect(board) {
	array_push(global.collected_boards, board);
	array_sort(global.collected_boards, true);
	save_file();
}

function board_collected(board) {
	return array_search(global.collected_boards, board);
}
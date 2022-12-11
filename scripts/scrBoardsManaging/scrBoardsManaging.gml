function Board(name, scene, makers, welcome, rules) constructor {
	self.name = name;
	self.scene = scene;
	self.makers = makers;
	self.welcome = welcome;
	self.rules = rules;
	self.alright = "Alright. Then let's choose the turns!";
}

function board_init() {
	global.boards = [
		new Board("Island", rBoardIsland, "KingSlendy\nJPRG666", "Welcome to this island! There's pretty much only ocean surrounding it. But it's still pretty nice!", ["In this board every 3 turns it'll cycle between day and night.", "At day you can use the Shop but can't use the Blackhole. At night you can use the Blackhole but can't use the Shop.", "When it's a night turn the Shine will have a random price. It can be 50, 40, 30, 10 or 0! It'll be at this price the remainder of the turn."]),
		new Board("Hotland", rBoardHotland, "KingSlendy\nJPRG666", "Welcome!", ["Yes"]),
		new Board("Baba Is Board", rBoardBaba, "KingSlendy", "Welcome!", ["Yes"]),
		new Board("Pallet Town", rBoardPallet, "KingSlendy", "Welcome!", ["Yes"]),
		new Board("Lucid Dreams", rBoardDreams, "Kogami Takara\nKingSlendy", "Welcome!", ["Yes"]),
		new Board("Hyrule", rBoardHyrule, "KingSlendy", "Welcome!", ["Yes"]),
		new Board("Outer Nsanity", rBoardNsanity, "KingSlendy", "Welcome!", ["Yes"])
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
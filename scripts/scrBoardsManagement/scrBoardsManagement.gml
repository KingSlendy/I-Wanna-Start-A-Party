function Board(name, scene, makers, welcome, rules) constructor {
	self.name = name;
	self.scene = scene;
	self.makers = makers;
	self.welcome = welcome;
	self.rules = rules;
	self.alright = language_get_text("PARTY_BOARD_ALRIGHT");
}

function board_init() {
	global.boards = [
		new Board(language_get_text("PARTY_BOARD_ISLAND_NAME"), rBoardIsland, "KingSlendy\nJPRG666", language_get_text("PARTY_BOARD_ISLAND_WELCOME"), [language_get_text("PARTY_BOARD_ISLAND_RULES_1"), language_get_text("PARTY_BOARD_ISLAND_RULES_2"), language_get_text("PARTY_BOARD_ISLAND_RULES_3", ["{40 coins}", draw_coins_price(40)], ["{30 coins}", draw_coins_price(30)], ["{10 coins}", draw_coins_price(10)], ["{0 coins}", draw_coins_price(0)])]),
		new Board(language_get_text("PARTY_BOARD_HOTLAND_NAME"), rBoardHotland, "KingSlendy\nJPRG666", language_get_text("PARTY_BOARD_HOTLAND_WELCOME"), [language_get_text("PARTY_BOARD_HOTLAND_RULES_1"), language_get_text("PARTY_BOARD_HOTLAND_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_BABA_NAME"), rBoardBaba, "KingSlendy", language_get_text("PARTY_BOARD_BABA_WELCOME"), [language_get_text("PARTY_BOARD_BABA_RULES_1"), language_get_text("PARTY_BOARD_BABA_RULES_2"), language_get_text("PARTY_BOARD_BABA_RULES_3")]),
		new Board(language_get_text("PARTY_BOARD_PALLET_NAME"), rBoardPallet, "KingSlendy", language_get_text("PARTY_BOARD_PALLET_WELCOME"), [language_get_text("PARTY_BOARD_PALLET_RULES_1"), language_get_text("PARTY_BOARD_PALLET_RULES_2", ["{15 coins}", draw_coins_price(15)]), language_get_text("PARTY_BOARD_PALLET_RULES_3", ["{10 coins}", draw_coins_price(10)], ["{10 coins}", draw_coins_price(10)]), language_get_text("PARTY_BOARD_PALLET_RULES_4"), language_get_text("PARTY_BOARD_PALLET_RULES_5"), language_get_text("PARTY_BOARD_PALLET_RULES_6")]),
		new Board(language_get_text("PARTY_BOARD_DREAMS_NAME"), rBoardDreams, "Kogami Takara\nKingSlendy", language_get_text("PARTY_BOARD_DREAMS_WELCOME"), [language_get_text("PARTY_BOARD_DREAMS_RULES_1"), language_get_text("PARTY_BOARD_DREAMS_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_HYRULE_NAME"), rBoardHyrule, "KingSlendy", language_get_text("PARTY_BOARD_HYRULE_WELCOME"), [language_get_text("PARTY_BOARD_HYRULE_RULES_1"), language_get_text("PARTY_BOARD_HYRULE_RULES_2"), language_get_text("PARTY_BOARD_HYRULE_RULES_3"), language_get_text("PARTY_BOARD_HYRULE_RULES_4", ["{20 coins}", draw_coins_price(20)]), language_get_text("PARTY_BOARD_HYRULE_RULES_5")]),
		new Board(language_get_text("PARTY_BOARD_NSANITY_NAME"), rBoardNsanity, "KingSlendy\nMauriPlays!", language_get_text("PARTY_BOARD_NSANITY_WELCOME"), [language_get_text("PARTY_BOARD_NSANITY_RULES_1"), language_get_text("PARTY_BOARD_NSANITY_RULES_2", ["{5 coins}", draw_coins_price(5)], ["{10 coins}", draw_coins_price(10)])]),
		new Board(language_get_text("PARTY_BOARD_WORLD_NAME"), rBoardWorld, "Kogami Takara\nKingSlendy", language_get_text("PARTY_BOARD_WORLD_WELCOME"), [language_get_text("PARTY_BOARD_WORLD_RULES_1"), language_get_text("PARTY_BOARD_WORLD_RULES_2")]),
		// Added - TODO: Languages
		new Board(language_get_text("PARTY_BOARD_FASF_NAME"), rBoardFASF, "Neos", language_get_text("PARTY_BOARD_FASF_WELCOME"), [language_get_text("PARTY_BOARD_FASF_RULES_1"), language_get_text("PARTY_BOARD_FASF_RULES_2")])
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
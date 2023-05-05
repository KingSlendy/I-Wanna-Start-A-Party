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
		new Board(language_get_text("PARTY_BOARD_ISLAND_NAME"), rBoardIsland, "KingSlendy\nJPRG666", language_get_text("PARTY_BOARD_ISLAND_WELCOME"), [language_get_text("PARTY_BOARD_ISLAND_RULES_1"), language_get_text("PARTY_BOARD_ISLAND_RULES_2"), "When it's a night turn the Shine will have a random price. It can be " + draw_coins_price(50) + " " + draw_coins_price(40) + " " + draw_coins_price(30) + " " + draw_coins_price(10) + " " + draw_coins_price(0) + "! It'll be at this price the remainder of the turn."]),
		new Board(language_get_text("PARTY_BOARD_HOTLAND_NAME"), rBoardHotland, "KingSlendy\nJPRG666", language_get_text("PARTY_BOARD_HOTLAND_WELCOME"), [language_get_text("PARTY_BOARD_HOTLAND_RULES_1"), language_get_text("PARTY_BOARD_HOTLAND_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_BABA_NAME"), rBoardBaba, "KingSlendy", language_get_text("PARTY_BOARD_BABA_WELCOME"), [language_get_text("PARTY_BOARD_BABA_RULES_1"), language_get_text("PARTY_BOARD_BABA_RULES_2"), language_get_text("PARTY_BOARD_BABA_RULES_3")]),
		new Board(language_get_text("PARTY_BOARD_PALLET_NAME"), rBoardPallet, "KingSlendy", language_get_text("PARTY_BOARD_PALLET_WELCOME"), [language_get_text("PARTY_BOARD_PALLET_RULES_1"), "When you pass over a Pokemon Space, you will have the option to catch that Pokemon for " + draw_coins_price(15) + " or to battle it.", "If you win against a Pokemon that has a Shine, you'll obtain it. If you win against a Pokemon with no Shine, it'll give you " + draw_coins_price(10) + ". If you lose however, you'll lose " + draw_coins_price(10) + ".", language_get_text("PARTY_BOARD_PALLET_RULES_4"), language_get_text("PARTY_BOARD_PALLET_RULES_5"), language_get_text("PARTY_BOARD_PALLET_RULES_6")]),
		new Board(language_get_text("PARTY_BOARD_DREAMS_NAME"), rBoardDreams, "Kogami Takara\nKingSlendy", language_get_text("PARTY_BOARD_DREAMS_WELCOME"), [language_get_text("PARTY_BOARD_DREAMS_RULES_1"), language_get_text("PARTY_BOARD_DREAMS_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_HYRULE_NAME"), rBoardHyrule, "KingSlendy", language_get_text("PARTY_BOARD_HYRULE_WELCOME"), [language_get_text("PARTY_BOARD_HYRULE_RULES_1"), language_get_text("PARTY_BOARD_HYRULE_RULES_2"), language_get_text("PARTY_BOARD_HYRULE_RULES_3"), "In the Dark World all the Shines become Evil Shines. They take away one Shine from you if you have one, or " + draw_coins_price(20) + " if you don't.", language_get_text("PARTY_BOARD_HYRULE_RULES_5")]),
		new Board(language_get_text("PARTY_BOARD_NSANITY_NAME"), rBoardNsanity, "KingSlendy\nMauriPlays!", language_get_text("PARTY_BOARD_NSANITY_WELCOME"), [language_get_text("PARTY_BOARD_NSANITY_RULES_1"), language_get_text("PARTY_BOARD_NSANITY_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_WORLD_NAME"), rBoardWorld, "Kogami Takara\nKingSlendy", language_get_text("PARTY_BOARD_WORLD_WELCOME"), [language_get_text("PARTY_BOARD_WORLD_RULES_1"), language_get_text("PARTY_BOARD_WORLD_RULES_2")])
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
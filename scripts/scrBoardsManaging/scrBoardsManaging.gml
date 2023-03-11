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
		new Board("Island", rBoardIsland, "KingSlendy\nJPRG666", "Welcome to the island! There's pretty much only ocean surrounding it. But it's still pretty nice!", ["This board has a 3 turn cycle between day and night.", "At day you can use the Shop but can't use the Blackhole. At night you can use the Blackhole but can't use the Shop.", "When it's a night turn the Shine will have a random price. It can be " + draw_coins_price(50) + draw_coins_price(40) + draw_coins_price(30) + draw_coins_price(10) + draw_coins_price(0) + "! It'll be at this price the remainder of the turn."]),
		new Board("Hotland", rBoardHotland, "KingSlendy\nJPRG666", "Welcome! My it's really hot in here... hope you don't mind the heat too much!", ["Two Shines are present on this board. The goal is to purchase the correct Shine! One of them is fake and the other is real. You won't know it until you pay for it!", "Once the fake Shine is discovered the other one is guaranteed to be real. If the real one is obtained. The fake one will disappear and two more Shines will spawn."]),
		new Board("Baba Is Board", rBoardBaba, "KingSlendy", "Welcome to drawings everywhere! Let's hope for no puzzle shenanigans.", ["There's some puzzle blocks on some paths, those blocks are toggled everytime you cross them.", "There's a block pair for Shines, one for Spaces and other for Shops. Depending on what the text says on the rightmost block, that's the thing it's gonna apply.", "The text from that block changes every turn, so be careful!"]),
		new Board("Pallet Town", rBoardPallet, "KingSlendy", "Welcome to the land of the Pokemon! Gotta catch 'em all!", ["Here your objective is to fight Pokemons, and win their Shines.", "When you pass over a Pokemon Space, you will have the option to catch that Pokemon for " + draw_coins_price(15) + " or to battle it.", "If you win against a Pokemon that has a Shine, you'll obtain it. If you win against a Pokemon with no Shine, it'll give you " + draw_coins_price(10) + ". If you lose however, you'll lose " + draw_coins_price(10) + ".", "Certain Pokemon types are more effective against others.\nThe hierarchy goes as follows: Water -> Fire -> Grass -> Water.", "If you have a favorable Pokemon type, your chances of winning are really high. If you have the same type it's half the chances. Otherwise it's really low.", "Now go and become a real Pokemon trainer!"]),
		new Board("Lucid Dreams", rBoardDreams, "Kogami Takara\nKingSlendy", "Welcome to your dreams! Is this how your dreams look like? That's LSD stuff right there.", ["Here you only need to reach the Shine as usual. The difference is that there's some teleports scattered throught the board.", "Every pair of two teleports are connected, you gotta remember where each one leads where!"]),
		new Board("Hyrule", rBoardHyrule, "KingSlendy", "Welcome to Hyrule! In the peaceful Kakariko Village no less.", ["This board has a unique thing going on. It spawns three Shines instead of only one. So what's the deal you say?", "When a new turn starts, there's a chance the board changes to the Dark World or back to the Light World.", "In the Light World everything works as you normally expect.", "In the Dark World all the Shines become Evil Shines. They take away one Shine from you if you have one, or " + draw_coins_price(20) + " if you don't.", "So be careful and try to avoid them as much as you can!"]),
		new Board("Outer Nsanity", rBoardNsanity, "KingSlendy\nMauriPlays!", "Welcome to the insanity! It's very interesting to be here in outer space.", ["This is a linear board, with only a single Shine. Your goal is to reach it fast!", "Why fast you ask? Because everytime someone buys a Shine the total cost goes up by 5! Starting from 20."]),
		new Board("Kid VS. The World", rBoardWorld, "Kogami Takara\nKingSlendy", "Welcome to everyone versus the world!", ["You gotta be careful! There's a spooky Ghost roaming around! When it reaches you or you reach it, it takes a Shine away!", "Plan your route accordingly and try to avoid Ghost at all costs while you collect Shines!"])
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
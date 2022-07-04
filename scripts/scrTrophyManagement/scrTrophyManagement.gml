function Trophy(image, rank, name, description, hint) constructor {
	self.image = image;
	self.rank = rank;
	self.name = name;
	self.description = description;
	self.hint = hint;
}

global.trophies = [
	new Trophy(1, 2, "Shiny!", "You obtained your first Shine!\nBut just one isn't enough, ain't it?", "You're gonna obtain one sooner or later."),
	new Trophy(2, 1, "Shinier!", "You obtained 50 Shines!\nBut is it really enough?", "I love me something shiny."),
	new Trophy(3, 0, "Shiny yet Shinier!", "You obtained 100 Shines!\nNow that's a decent amount.", "I WANT MORE SHINY!!!"),
	new Trophy(4, 1, "Kidiana Jones", "You found a Hidden Chest!\nEvery good explorer finds treasure! Or wait... maybe you're just lucky.", "Something's hidden in this space... I swear..."),
	new Trophy(5, 0, "Shiny Chest", "You found a Shine within a Hidden Chest!?\nNow that's peak exploring... I mean luck right there.", "Why couldn't this give me something shinier?"),
	new Trophy(6, 1, "Money Money", "You reached 100 Coins in Party!\nWhat does it feel to be rich?", "I wanna be able to purchase anything!"),
	new Trophy(7, 2, "Coinless", "You went down to 0 Coins in Party...\nWelp, time to live in the streets.", "You don't wanna lose that many."),
	new Trophy(8, 2, "Memory Magician", "You scored a perfect 10 in Magic Memory.\nCan I borrow that memory of yours for a second?", "How can you keep so many items in your head?"),
	new Trophy(9, 2, "Messed Memory", "You didn't put any items in the pedestals in Magic Memory...\nAt least try!", "You can't have that bad of a memory..."),
	new Trophy(10, 2, "Tie your tie", "You obtained a Tie in a minigame.\nWelp guess no one wins anything.", "Seriously? No one wins?"),
	new Trophy(11, 2, "Flexing Ghosts", "You went back after almost reaching the light in Haunted Forest.\nNow that's just showing off.", "Spooky stuff ain't that scary for you."),
	new Trophy(12, 2, "Darkness' Friend", "You said 'No' to the Shine.\nLiving in darkness it is.", "I prefer not being too bright, thank you very much."),
	new Trophy(13, 0, "Showdown Survivor", "You survived all 3 rounds with your team in Number Showdown.\nThat's teamwork for you! Or not?", "That was certainly a showdown teamwork."),
	new Trophy(14, 0, "Showdown Killer", "You killed the whole team in the first round in Number Showdown.\nIn cold blood.", "You better not murder the showdown."),
	new Trophy(15, 0, "Expert Escapist", "You chose only the correct doors in Mansion Escape.\nHoudini would be proud of you.", "Escaping? Piece of cake."),
	new Trophy(16, 2, "Spiky Dodger", "You dodged all of the spikes in Getting Coins.\nSquare shaped spikes are just that easy to dodge.", "I prefer triangular spikes."),
	new Trophy(17, 0, "Red Coin", "You collected a red coin in Getting Coins!\nFINALLY! The red coin in this G stage was really hard. Or wait... is this the wrong game?", "The red in G is pretty tough."),
	new Trophy(18, 2, "Broken Elevator", "You died on the very first row of spikes in Tower Ascension.\nHaving the high ground wasn't appealing.", "I have the lower ground!"),
	new Trophy(19, 2, "Conveyor Victory", "You jumped directly to the ceiling spikes in Conveyor Havoc.\nDid you think you could escape the conveyor by jumping? Think again.", "Jump straight to victory! And by victory I mean death."),
	new Trophy(20, 0, "Double Trouble", "You rolled two identical numbers with Double Dice!\nMore rolling for me!", "Double the numbers, double the fun."),
	new Trophy(21, 0, "Sonic Speed", "You rolled 25 or more with Triple Dice!\nJust casually going for a walk around the board, no big deal.", "Hey slow down a little bit!"),
	new Trophy(22, 2, "Snail Pace", "You rolled 10 or less with a Triple Dice.\nI'm gonna reach the Shine, I swear...", "I would've used a regular one if I knew this was gonna happen..."),
	new Trophy(23, 1, "Pattern Expert", "You found all pattern pairs first in Colorful Insanity.\nLosing stuff isn't a problem for you.", "Those finding skills would come in handy when I'm trying to find my keys between my mess."),
	new Trophy(24, 2, "Negative Coins", "You landed on a Red space when having 0 coins.\nWhat does it feel to be at -3 coins?", "I can't lose more, stop!!"),
	new Trophy(25, 1, "Turning Red", "All of you turned Red before the minigame was chosen.\nRed everywhere you see.", "Living all the red!"),
	new Trophy(26, 2, "Catch The Small", "You catched most of or all the small fruits in Catch The Fruits!\nThat level of accuracy must be worth at least 1,000pp", "It's just like playing osu!\nBut I go small."),
	new Trophy(27, 1, "Catch The Gordos", "You catched almost all or all the gordos in Catch The Fruits.\nIs spikes your thing or what?", "Meh fruits isn't the thing for me."),
	new Trophy(28, 2, "Cornered Maze", "You went to the opposite corner in A-Maze-Ing.\nWere you that lost?", "I'm so lost I'm on the other end!"),
	new Trophy(29, 2, "Lonely Spikes", "You died to the top spikes in Unstable Blocks.\nWait, why? It's literally not moving.\nYou did it on purpose I swear.", "Those are at the very top, that can't seriously happen."),
	new Trophy(30, 2, "Scoring Squares", "You scored 22 in Fitting Squares!\nI bet you can do a T-Spin with that level of precision.", "I hope all that Tetris training will pay off."),
	new Trophy(31, 1, "100 Shine Debt", "You obtained 100 Shines landing on The Guy space!\nYES! 100 SHINES SIGN ME UP!\nWait... where are my Shines!!??", "Even a bad guy can give you something shiny."),
	new Trophy(32, 1, "Party Winner", "You won a Party!\nI want more parties! Bring it on!", "A winner is you."),
	new Trophy(33, 1, "Party Loser", "You lost a Party...\nWell there's always next time I guess.", "A loser is you."),
	new Trophy(34, 1, "Where's My Shiny?", "You ended a Party with 0 Shines...\nWell that's kinda unfortunate, I mean... that's the whole point, getting shines.", "Wait... isn't the whole point getting shiny?")
];

global.collected_trophies_stack = [];

function gain_trophy(trophy) {
	if (have_trophy(trophy)) {
		return;
	}
	
	if (!instance_exists(objCollectedTrophy)) {
		collect_trophy(trophy);
	} else {
		array_push(global.collected_trophies_stack, trophy);
	}
	
	array_push(global.collected_trophies, trophy);
	array_sort(global.collected_trophies, true);
	
	if (!global.minigame_info.is_modes) {
		var amount = 0;
		var now_trophy = global.trophies[trophy];
		
		switch (now_trophy.rank) {
			case 2: amount = 50; break;
			case 1: amount = 200; break;
			case 0: amount = 500; break;
		}
		
		increase_collected_coins(amount);
	}
	
	save_file();
}

function have_trophy(trophy) {
	return (array_contains(global.collected_trophies, trophy));
}

function collect_trophy(trophy) {
	var now_trophy = global.trophies[trophy];
	var t = instance_create_layer(0, 0, "Managers", objCollectedTrophy);
	t.rank = now_trophy.rank;
	t.image = now_trophy.image;
	t.trophy = trophy;
}

function increase_collected_coins(amount) {
	if (amount == 0) {
		return;
	}
	
	var c = instance_create_layer(0, 0, "Managers", objCollectedCoins);
	c.amount = amount;
	global.collected_coins += amount;
}

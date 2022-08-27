function Trophy(image, rank, name, description, hint) constructor {
	self.image = image;
	self.rank = rank;
	self.name = name;
	self.description = description;
	self.hint = hint;
}

enum TrophyRank {
	Platinum,
	Gold,
	Silver,
	Bronze,
	Unknown
}

global.trophies = [
	new Trophy(1, TrophyRank.Bronze, "Shiny!", "You obtained 10 Shines!\nBut just ten isn't enough, ain't it?", "You're gonna obtain the shiny sooner or later."),
	new Trophy(2, TrophyRank.Silver, "Shinier!", "You obtained 50 Shines!\nBut is it really enough?", "I love me something shiny."),
	new Trophy(3, TrophyRank.Gold, "Shiny yet Shinier!", "You obtained 100 Shines!\nNow that's a decent amount.", "I WANT MORE SHINY!!!"),
	new Trophy(4, TrophyRank.Silver, "Kidiana Jones", "You found a Hidden Chest!\nEvery good explorer finds treasure! Or wait... maybe you're just lucky.", "Something's hidden in this space... I swear..."),
	new Trophy(5, TrophyRank.Platinum, "Shiny Chest", "You found a Shine within a Hidden Chest!?\nNow that's peak exploring... I mean luck right there.", "Why couldn't this give me something shinier?"),
	new Trophy(6, TrophyRank.Silver, "Money Money", "You reached 100 Coins in Party!\nWhat does it feel to be rich?", "I wanna be able to purchase anything!"),
	new Trophy(7, TrophyRank.Bronze, "Coinless", "You went down to 0 Coins in Party...\nWelp, time to live in the streets.", "You don't wanna lose that many."),
	new Trophy(8, TrophyRank.Bronze, "Memory Magician", "You scored a perfect 10 in Magic Memory.\nCan I borrow that memory of yours for a second?", "How can you keep so many items in your head?"),
	new Trophy(9, TrophyRank.Bronze, "Messed Memory", "You didn't put any items in the pedestals in Magic Memory...\nAt least try!", "You can't have that bad of a memory..."),
	new Trophy(10, TrophyRank.Bronze, "Tie Your tie", "You obtained a Tie in a minigame.\nWelp guess no one wins anything.", "Seriously? No one wins?"),
	new Trophy(11, TrophyRank.Bronze, "Flexing Ghosts", "You went back after almost reaching the light in Haunted Forest.\nNow that's just showing off.", "Spooky stuff ain't that scary for you."),
	new Trophy(12, TrophyRank.Bronze, "Darkness' Friend", "You said 'No' to the Shine.\nLiving in darkness it is.", "I prefer not being too bright, thank you very much."),
	new Trophy(13, TrophyRank.Gold, "Showdown Survivor", "You survived all 3 rounds with your team in Number Showdown.\nThat's teamwork for you! Or not?", "That was certainly a showdown teamwork."),
	new Trophy(14, TrophyRank.Gold, "Showdown Killer", "You killed the whole team in the first round in Number Showdown.\nIn cold blood.", "You better not murder the showdown."),
	new Trophy(15, TrophyRank.Gold, "Expert Escapist", "You chose only the correct doors in Mansion Escape.\nHoudini would be proud of you.", "Escaping? Piece of cake."),
	new Trophy(16, TrophyRank.Bronze, "Spiky Dodger", "You dodged all of the spikes in Getting Coins.\nSquare shaped spikes are just that easy to dodge.", "I prefer triangular spikes."),
	new Trophy(17, TrophyRank.Gold, "Red Coin", "You collected a red coin in Getting Coins!\nFINALLY! The red coin in this G stage was really hard. Or wait... is this the wrong game?", "The red in G is pretty tough."),
	new Trophy(18, TrophyRank.Bronze, "Broken Elevator", "You died on the very first row of spikes in Tower Ascension.\nHaving the high ground wasn't appealing.", "I have the lower ground!"),
	new Trophy(19, TrophyRank.Bronze, "Conveyor Victory", "You jumped directly to the ceiling spikes in Conveyor Havoc.\nDid you think you could escape the conveyor by jumping? Think again.", "Jump straight to victory! And by victory I mean death."),
	new Trophy(20, TrophyRank.Gold, "Double Trouble", "You rolled two identical numbers with Double Dice!\nMore rolling for me!", "Double the numbers, double the fun."),
	new Trophy(21, TrophyRank.Gold, "Sonic Speed", "You rolled 25 or more with Triple Dice!\nJust casually going for a walk around the board, no big deal.", "Hey slow down a little bit!"),
	new Trophy(22, TrophyRank.Bronze, "Snail Pace", "You rolled 10 or less with a Triple Dice.\nI'm gonna reach the Shine, I swear...", "I would've used a regular one if I knew this was gonna happen..."),
	new Trophy(23, TrophyRank.Silver, "Pattern Expert", "You found all pattern pairs first in Colorful Insanity.\nLosing stuff isn't a problem for you.", "Those finding skills would come in handy when I'm trying to find my keys between my mess."),
	new Trophy(24, TrophyRank.Bronze, "Negative Coins", "You landed on a Red space when having 0 coins.\nWhat does it feel to be at -3 coins?", "I can't lose more, stop!!"),
	new Trophy(25, TrophyRank.Silver, "Turning Red", "All of you turned Red before the minigame was chosen.\nRed everywhere you see.", "Living all the red!"),
	new Trophy(26, TrophyRank.Bronze, "Catch The Small", "You catched most of or all the small fruits in Catch The Fruits!\nThat level of accuracy must be worth at least 1,000pp", "It's just like playing osu!\nBut I go small."),
	new Trophy(27, TrophyRank.Silver, "Catch The Gordos", "You catched almost all or all the gordos in Catch The Fruits.\nIs spikes your thing or what?", "Meh fruits isn't the thing for me."),
	new Trophy(28, TrophyRank.Bronze, "Cornered Maze", "You went to the opposite corner in A-Maze-Ing.\nWere you that lost?", "I'm so lost I'm on the other end!"),
	new Trophy(29, TrophyRank.Bronze, "Lonely Spikes", "You died to the top spikes in Unstable Blocks.\nWait, why? It's literally not moving.\nYou did it on purpose I swear.", "Those are at the very top, that can't seriously happen."),
	new Trophy(30, TrophyRank.Bronze, "Scoring Squares", "You scored 22 in Fitting Squares!\nI bet you can do a T-Spin with that level of precision.", "I hope all that Tetris training will pay off."),
	new Trophy(31, TrophyRank.Silver, "100 Shine Debt", "You obtained 100 Shines landing on The Guy space!\nYES! 100 SHINES SIGN ME UP!\nWait... where are my Shines!!??", "Even a bad guy can give you something shiny."),
	new Trophy(32, TrophyRank.Silver, "Party Winner", "You won a Party!\nI want more parties! Bring it on!", "A winner is you."),
	new Trophy(33, TrophyRank.Silver, "Party Loser", "You lost a Party...\nWell there's always next time I guess.", "A loser is you."),
	new Trophy(34, TrophyRank.Silver, "Where's My Shiny?", "You ended a Party with 0 Shines...\nWell that's kinda unfortunate, I mean... that's the whole point, getting shines.", "Wait... isn't the whole point getting shiny?"),
	new Trophy(35, TrophyRank.Silver, "Free Night", "You received a Night Shine for 0 coins!\nThat was free trial, next time you won't be so lucky.", "This one is on the house."),
	new Trophy(36, TrophyRank.Silver, "Expensive Night", "You bought a Night Shine for 40 coins.\nIt'd be best if you waited for sales next time.", "Gimme full price! I ain't waiting for the hot sale."),
	new Trophy(37, TrophyRank.Platinum, "Triple Threat", "You rolled three identical numbers with Triple Dice!\nI can't stop rolling!", "Oh baby, a triple!"),
	new Trophy(38, TrophyRank.Silver, "Dyslexic Pusher", "You pushed the block in Warping Up the wrong way.\nBut that's harder! Why would you think of doing that!?", "Wait, pushing it to the other side...?"),
	new Trophy(39, TrophyRank.Bronze, "Slime Hugger", "You touched the slime in Slime Annoyer.\nIt's cute, I know, but it's deadly!", "I know it's tempting, but it's not huggable."),
	new Trophy(40, TrophyRank.Gold, "After Hours", "Finish a 50 turns Party.\nLook! It's morning outside!", "Never ending Party."),
	new Trophy(41, TrophyRank.Bronze, "Item Hoarder", "You finished a Party with 3 Items.\nOh my, that's such a waste!", "Hoarding isn't the best, you know?"),
	new Trophy(42, TrophyRank.Bronze, "Broken Mirror", "You used the Mirror when you didn't have enough coins.\nNow both you and the Mirror are broke, congratulations!", "Now two things are broken by such waste."),
	new Trophy(43, TrophyRank.Bronze, "Night Shift", "You used the Cellphone when it was night.\nSorry but the shop doesn't have night shifts.\nIt'd be best if you actually went during the day, thank you.", "Pay attention to the customer support schedule."),
	new Trophy(44, TrophyRank.Silver, "Dizzy Crazy", "You touched every warp in Dizzy Conundrum.\nStop! You're making me dizzy!", "My head is spinning..."),
	new Trophy(45, TrophyRank.Silver, "Born Astronaut", "You didn't receive a single hit in Rocket Ignition!\nAll those years of astronaut training in the morning finally paid off!", "Morning training routine."),
	new Trophy(46, TrophyRank.Bronze, "Wrong Number", "You used the Cellphone and said no.\nCalling the wrong number, happens from time to time.", "Woops, that's not the right number, my bad."),
	new Trophy(47, TrophyRank.Bronze, "Wrong Galaxy", "You used the Blackhole and said no.\nYeah there's a bunch of galaxies to call, it's only natural you'd get confused.", "Woops, that's not the right galaxy, my bad."),
	new Trophy(48, TrophyRank.Bronze, "Target Master", "You hit a yellow target first in Targetting Targets.\nWith that level of aiming you should be able to win everytime.", "Professional level aimer."),
	new Trophy(49, TrophyRank.Bronze, "Duel Marker", "You shot before the mark showed up everytime in Western Duel.\nI get that shooting faster is what you're supposed to do, but here you gotta wait for the mark!", "Waiting for the mark!?\nPfff, I'm faster."),
	new Trophy(50, TrophyRank.Bronze, "High Ball", "You made the soccer ball land above the net in Soccer Match.\nI'm certainly impressed because getting the ball up there is harder than scoring a goal.", "Great job, now get it back down so we can continue.")
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
			case 3: amount = 50; break;
			case 2: amount = 200; break;
			case 1: amount = 500; break;
			case 0: amount = 2000; break;
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

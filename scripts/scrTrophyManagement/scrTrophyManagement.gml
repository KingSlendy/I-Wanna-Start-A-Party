global.trophy_hint_price = 100;
global.trophy_spoiler_price = 1000;

function Trophy(image, rank, name, description, short) constructor {
	self.image = image;
	self.rank = rank;
	self.name = name;
	self.description = description;
	self.short = short;
	self.location = -1;
	
	static achieve = function() {
		if (!instance_exists(objCollectedTrophy)) {
			var t = instance_create_layer(0, 0, "Managers", objCollectedTrophy);
			t.rank = self.rank;
			t.image = self.image;
			t.trophy = self.image - 1;
		} else {
			array_push(global.collected_trophies_stack, self.image - 1);
		}
	
		array_push(global.collected_trophies, self.image - 1);
		array_sort(global.collected_trophies, true);
		self.hint();
		self.spoiler();
		var amount = 0;
		
		switch (self.rank) {
			case TrophyRank.Bronze: amount = 100; break;
			case TrophyRank.Silver: amount = 200; break;
			case TrophyRank.Gold: amount = 1000; break;
			case TrophyRank.Platinum: amount = 2000; break;
		}
		
		change_collected_coins(amount);
		save_file();
	}
	
	static hint = function() {
		array_push(global.collected_hint_trophies, self.image - 1);
		array_sort(global.collected_hint_trophies, true);
		save_file();
	}
	
	static spoiler = function() {
		array_push(global.collected_spoiler_trophies, self.image - 1);
		array_sort(global.collected_spoiler_trophies, true);
		save_file();
	}
	
	static state = function() {
		if (achieved_trophy(self.image - 1) || spoilered_trophy(self.image - 1)) {
			return TrophyState.Known;
		}
		
		if (hinted_trophy(self.image - 1)) {
			return TrophyState.Hint;
		}
		
		return TrophyState.Unknown;
	}
}

enum TrophyRank {
	Platinum,
	Gold,
	Silver,
	Bronze,
	Unknown
}

enum TrophyState {
	Known,
	Hint,
	Unknown
}

global.trophies = [
	///Boards
	new Trophy(1, TrophyRank.Bronze, "Shiny!", "You obtained 10 Shines!\nI can do more!", "You're gonna obtain the shiny sooner or later."),
	new Trophy(2, TrophyRank.Silver, "Shinier!", "You obtained 50 Shines!\nBut is it really enough?", "I love me something shiny."),
	new Trophy(3, TrophyRank.Gold, "Shiny yet Shinier!", "You obtained 100 Shines!\nNow that's a decent amount.", "I WANT MORE SHINY!!!"),
	new Trophy(6, TrophyRank.Silver, "Money Money", "You reached 100 Coins in Party!\nWhat does it feel to be rich?", "I wanna be able to purchase anything!"),
	new Trophy(7, TrophyRank.Bronze, "Coinless", "You went down to 0 Coins in Party...\nWelp, time to live in the streets.", "You don't wanna lose that many."),
	new Trophy(56, TrophyRank.Bronze, "Numberphile", "You got the same number for the place, Shines and Coins!You love seeing the same number!", "Hey I have the same number for everything!"),
	new Trophy(12, TrophyRank.Bronze, "Darkness' Friend", "You said 'No' to the Shine.\nLiving in darkness it is.", "I prefer not being too bright, thank you very much."),
	new Trophy(4, TrophyRank.Silver, "Kidiana Jones", "You found a Hidden Chest!\nEvery good explorer finds treasure! Or wait... maybe you're just lucky.", "Something's hidden in this space... I swear..."),
	new Trophy(5, TrophyRank.Platinum, "Shiny Chest", "You found a Shine within a Hidden Chest!?\nNow that's peak exploring... I mean luck right there.", "Why couldn't this give me something shinier?"),
	new Trophy(24, TrophyRank.Bronze, "Negative Coins", "You landed on a Red space when having 0 Coins.\nWhat does it feel to be at -3 Coins?", "I can't lose more, stop!!"),
	new Trophy(61, TrophyRank.Gold, "Spare Items", "You received a Blackhole or a Mirror from an item space!\nNow that's a handy item after so many Poisons!", "Heck yeah! I was getting tired of so many lame items in this space!\nThis is definitely better!"),
	new Trophy(31, TrophyRank.Silver, "100 Shine Debt", "You obtained 100 Shines landing on The Guy space!\nYES! 100 SHINES SIGN ME UP!\nWait... where are my Shines!!??", "Even a bad guy can give you something shiny."),
	new Trophy(55, TrophyRank.Platinum, "1 Coin Payment", "You received 1 coin landing on The Guy space...\nReally...? That's it...? Kinda hoping for a little bit more considering I had nothing...", "Even a bad guy can give you... something...?"),
	new Trophy(25, TrophyRank.Silver, "Landing Red", "All of you landed on Red spaces.\nRed everywhere you see.", "Living all the red!"),
	new Trophy(71, TrophyRank.Gold, "Landing Green", "All of you landed on Green spaces.\nGreen everywhere you see.", "Living all the green!"),
	new Trophy(72, TrophyRank.Bronze, "Landing Colors", "All of you landed on different colored spaces.\nDifferent colors everywhere you see.", "Living all the different colors!"),
	new Trophy(62, TrophyRank.Platinum, "Turning Tables", "You recieved a Shine in the last 5 turns event!\nThat was unexpected, the other players are hating you right now!", "I bet you weren't expecting to get that on the last 5 turns!"),
	new Trophy(57, TrophyRank.Silver, "Blue Savior", "You landed on a blue space when all the blue spaces were red spaces!\nAt least you gained something while this mess was happening.", "Landing on a good one while there's so many bad ones."),
	new Trophy(46, TrophyRank.Bronze, "Wrong Number", "You used the Cellphone and said no.\nCalling the wrong number, happens from time to time.", "Woops, that's not the right number, my bad."),
	new Trophy(47, TrophyRank.Bronze, "Wrong Galaxy", "You used the Blackhole and said no.\nYeah there's a bunch of galaxies to call, it's only natural you'd get confused.", "Woops, that's not the right galaxy, my bad."),
	new Trophy(20, TrophyRank.Gold, "Double Trouble", "You rolled two identical numbers with Double Dice!\nMore rolling for me!", "Double the numbers, double the fun."),
	new Trophy(21, TrophyRank.Gold, "Sonic Speed", "You rolled 25 or more with Triple Dice!\nJust casually going for a walk around the board, no big deal.", "Hey slow down a little bit!"),
	new Trophy(22, TrophyRank.Bronze, "Snail Pace", "You rolled 10 or less with a Triple Dice.\nI'm gonna reach the Shine, I swear...", "I would've used a regular one if I knew this was gonna happen..."),
	new Trophy(37, TrophyRank.Platinum, "Triple Threat", "You rolled three identical numbers with Triple Dice!\nI can't stop rolling!", "Oh baby, a triple!"),
	new Trophy(42, TrophyRank.Bronze, "Broken Mirror", "You used the Mirror when you didn't have enough Coins.\nNow both you and the Mirror are broken, congratulations!", "Now two things are broken by such waste."),
	
	//Island
	new Trophy(35, TrophyRank.Silver, "Free Night", "You received a Night Shine for 0 Coins in the Island board!\nThat was free trial, next time you won't be so lucky.", "This one is on the house."),
	new Trophy(36, TrophyRank.Silver, "Expensive Night", "You bought a Night Shine for 40 Coins in the Island board.\nIt'd be best if you waited for sales next time.", "Gimme full price! I ain't waiting for the hot sale."),
	new Trophy(43, TrophyRank.Bronze, "Night Shift", "You used the Cellphone when it was night.\nSorry but the shop doesn't have night shifts.\nIt'd be best if you actually went during the day, thank you.", "Pay attention to the customer support schedule."),
	
	//Pallet
	new Trophy(73, TrophyRank.Platinum, "Pokemon Not Trainer", "You won without catching a Pokemon in the Pallet Town board!\nI thought your dream was to become a Pokemon trainer... where's your Pokemon then?", "Not gotta catch 'em all!"),
	new Trophy(74, TrophyRank.Silver, "It's Not Effective", "You lost a Pokemon battle while having a favorable Pokemon in the Pallet Town board.\nWell that's some tough luck right there. Maybe try a different Pokemon next time.", "Water vs. Fire should be an easy win... right?"),
	new Trophy(75, TrophyRank.Gold, "It's Very Effective", "You won a Pokemon battle while not having a favorable Pokemon in the Pallet Town board.!\nI didn't think a fire attack against a water type was gonna work out. But I'm not complaining!", "Fire vs. Water could never work out... right?"),
	
	//Hyrule
	new Trophy(51, TrophyRank.Bronze, "Evil Mirror", "You used the Mirror in Dark World in the Hyrule board.\nDid you know you can't see your reflection in the dark?\nThen I wonder why you used this.", "I wonder what my reflection looks like when it's dark."),
	
	
	///Minigames
	new Trophy(10, TrophyRank.Bronze, "Tie Your tie", "You obtained a Tie in a minigame.\nWelp guess no one wins anything.", "Seriously? No one wins?"),
	
	//4vs
	new Trophy(18, TrophyRank.Bronze, "Broken Elevator", "You died on the very first row of spikes in Tower Ascension.\nHaving the high ground wasn't appealing.", "I have the lower ground!"),
	new Trophy(11, TrophyRank.Bronze, "Flexing Ghosts", "You went back after almost reaching the light in Haunted Forest.\nNow that's just showing off.", "Spooky stuff ain't that scary for you."),
	new Trophy(8, TrophyRank.Bronze, "Memory Magician", "You scored a perfect 10 in Magic Memory.\nCan I borrow that memory of yours for a second?", "How can you keep so many items in your head?"),
	new Trophy(9, TrophyRank.Bronze, "Messed Memory", "You got all items wrong in Magic Memory...\nI bet you forget your house keys everytime you go out, huh?", "You can't have that bad of a memory..."),
	new Trophy(15, TrophyRank.Gold, "Expert Escapist", "You chose only the correct doors in Mansion Escape.\nHoudini would be proud of you.", "Escaping? Piece of cake."),
	new Trophy(29, TrophyRank.Bronze, "Lonely Spikes", "You died to the top spikes in Unstable Blocks.\nWait, why? It's literally not moving.\nYou did it on purpose I swear.", "Those are at the very top, that can't seriously happen."),
	new Trophy(64, TrophyRank.Platinum, "Empty Chests", "You scored 0 points by going for the empty chests in Crazy Chests.\nThose chests were kind of a scam, huh?", "Hey wait a minute... these chests are empty!"),
	new Trophy(39, TrophyRank.Bronze, "Slime Hugger", "You touched the slime in Slime Annoyer.\nIt's cute, I know, but it's deadly!", "I know it's tempting, but it's not huggable."),
	new Trophy(45, TrophyRank.Silver, "Born Astronaut", "You didn't receive a single hit in Rocket Ignition!\nAll those years of astronaut training in the morning finally paid off!", "Morning rocket training routine."),
	new Trophy(44, TrophyRank.Gold, "Dizzy Crazy", "You touched every warp in Dizzy Conundrum.\nStop! You're making me dizzy!", "My head is spinning..."),
	new Trophy(52, TrophyRank.Gold, "Motion Sickness", "You never touched a warp and won in Dizzy Conundrum!\nMy you must really hate being dizzy.", "Being dizzy for too long makes me sick."),
	new Trophy(48, TrophyRank.Bronze, "Target Master", "You hit a yellow target first in Targetting Targets.\nWith that level of aiming you should be able to win everytime.", "Professional level aimer."),
	new Trophy(60, TrophyRank.Bronze, "Wall Master", "You wasted all your bullets in Targeting Targets.\nThe point was to shoot targets and not walls in case you didn't know.", "Wasting ammo to not hit any, great."),
	new Trophy(59, TrophyRank.Silver, "Reyo Keys", "You didn't grab a single green key and won in Drawn Keys!\nGoing for the big prize keys here!", "Green is too low."),
	new Trophy(68, TrophyRank.Bronze, "Bubble Racing", "You didn't touch a single spike and won in Bubble Derby!\nAll that Kamilia 3 speedrunning must've paid off, huh?", "Bubble maneuvers."),
	new Trophy(76, TrophyRank.Bronze, "Green Savings", "You only touched green saves and won in Sky Diving!\nThat satisfaction to see the green circle after a long save, am I right?", "I prefer the green circles for yellow boxes."),
	new Trophy(63, TrophyRank.Silver, "Flag Toucher", "You scored 99 points in Golf Course.\nHere hoping for the wind to barely move the ball, right?", "Come on, man! The flag is right there!"),
	new Trophy(67, TrophyRank.Silver, "Mini Golf", "You won while not leaving the main island in Golf Course!\nToo lazy to do a normal shot, aren't you?", "I barely attempted to get to the flag and I still won."),
	new Trophy(70, TrophyRank.Silver, "Luigi-Man", "You won by doing nothing in Waka Evasion!\nLuigi must be so proud of you right now.", "Luigi meets namco!"),
	
	//1vs3
	new Trophy(19, TrophyRank.Bronze, "Conveyor Victory", "You jumped directly to the ceiling spikes in Conveyor Havoc.\nDid you think you could escape the conveyor by jumping? Think again.", "Jump straight to victory! And by victory I mean death."),
	new Trophy(13, TrophyRank.Gold, "Showdown Survivor", "You survived all 3 rounds with your team in Number Showdown.\nThat's teamwork for you! Or not?", "That was certainly a showdown teamwork."),
	new Trophy(14, TrophyRank.Gold, "Showdown Killer", "You killed the whole team in the first round in Number Showdown.\nIn cold blood.", "You better not murder the showdown."),
	new Trophy(16, TrophyRank.Bronze, "Coin Dodger", "You didn't grab a single coin in Getting Coins.\nThe point is to collect them not to dodge them.", "There's a lot of coins, but I prefer being poor."),
	new Trophy(17, TrophyRank.Gold, "Red Coin", "You collected a red coin in Getting Coins!\nFINALLY! The red coin in this G stage was really hard. Or wait... is this the wrong game?", "The red in G is pretty tough."),
	new Trophy(38, TrophyRank.Silver, "Dyslexic Pusher", "You pushed the block in Warping Up the wrong way.\nBut that's harder! Why would you think of doing that!?", "Wait, pushing it to the other side...?"),
	new Trophy(77, TrophyRank.Bronze, "Dodging Teleports", "You didn't touch a single warp from the players and won in Warping Up!\nI guess you're getting tired of seeing the same warp over and over all the time.", "Not the gray teleporter!"),
	new Trophy(54, TrophyRank.Silver, "Block Hunter", "You touched all the blocks in Hunt Trouble.\nNow that's an stylish way of not getting hunted.", "Being hunted isn't fun unless you touch them all."),
	new Trophy(53, TrophyRank.Silver, "Block Saver", "You didn't destroy a single normal block and won in Aiming Tiles!\nYou're a block saver now!", "Let the blocks live!"),
	
	//2vs2
	new Trophy(28, TrophyRank.Bronze, "Cornered Maze", "You went to the opposite corner in A-Maze-Ing.\nWere you that lost?", "I'm so lost I'm on the other end!"),
	new Trophy(26, TrophyRank.Bronze, "Catch The Small", "You caught the most of or all the small fruits in Catch The Fruits!\nThat level of accuracy must be worth at least 1,000pp", "It's just like playing osu!\nBut I go small."),
	new Trophy(27, TrophyRank.Silver, "Catch The Gordos", "You catched almost all or all the gordos in Catch The Fruits.\nIs spikes your thing or what?", "Meh fruits isn't the thing for me."),
	new Trophy(30, TrophyRank.Bronze, "Scoring Squares", "You scored 22 in Fitting Squares!\nI bet you can do a T-Spin with that level of precision.", "I hope all that Tetris training will pay off."),
	new Trophy(23, TrophyRank.Silver, "Pattern Expert", "You found all pattern pairs first in Colorful Insanity.\nLosing stuff isn't a problem for you.", "Those finding skills would come in handy when I'm trying to find my keys between my mess."),
	new Trophy(69, TrophyRank.Bronze, "Piranha Fanatic", "You touched the piranha plant in Springing Piranha.\nThere's so much dodging at hand and yet you somehow touched the piranha!?", "Don't worry, that thing is scary so you don't have to worry to touch it."),
	new Trophy(49, TrophyRank.Bronze, "Duel Marker", "You shot before the mark showed up everytime in Western Duel.\nI get that shooting faster is what you're supposed to do, but here you gotta wait for the mark!", "Waiting for the mark!?\nPfff, I'm faster."),
	new Trophy(66, TrophyRank.Silver, "Cuadruple Kill", "All 4 players died in Western Duel.\nAll of you are either really good or really bad.", "Two duels, four deaths!"),
	new Trophy(50, TrophyRank.Bronze, "High Ball", "You made the soccer ball land above the net in Soccer Match.\nI'm certainly impressed because getting the ball up there is harder than scoring a goal.", "Great job, now get it back down so we can continue."),
	
	
	//Results
	new Trophy(32, TrophyRank.Silver, "Party Winner", "You won a Party!\nI want more parties! Bring it on!", "A winner is you."),
	new Trophy(33, TrophyRank.Silver, "Party Loser", "You lost a Party...\nWell there's always next time I guess.", "A loser is you."),
	new Trophy(40, TrophyRank.Gold, "After Hours", "Finish a 50 turn Party.\nLook! It's morning outside!", "Never ending Party."),
	new Trophy(41, TrophyRank.Bronze, "Item Hoarder", "You finished a Party with 3 Items.\nOh my, that's such a waste!", "Hoarding isn't the best, you know?"),
	new Trophy(34, TrophyRank.Silver, "Where's My Shiny?", "You ended a Party with 0 Shines...\nWell that's kinda unfortunate, I mean... that's the whole point, getting Shines.", "Wait... isn't the whole point getting shiny?"),
	new Trophy(58, TrophyRank.Gold, "Minigame Expert", "You won every single minigame in Party!\nI wish I could win all the Minigames as well to gain a bunch of Coins!", "You're that much of an expert you won all of them."),
	
	
	//All
	new Trophy(65, TrophyRank.Platinum, "All Minigames", "You unlocked all Minigames!\nThe full package is now on your hands!", "I want all the Minigames!"),
	new Trophy(78, TrophyRank.Platinum, "All Trials", "You completed all Trials!\nNow you can truly call yourself the life of the Party.", "I can beat all the Trials!"),
	new Trophy(79, TrophyRank.Platinum, "All Stores", "You bought everything in the Store!\nThere's just so many things to use, it never ends!", "I want everything in the Store!"),
	new Trophy(80, TrophyRank.Platinum, "All Trophies", "You got every single Trophy!!!\nThanks for participating in this Party, hopefully this won't be the last one!", "The life of the party!")
];

for (var i = 0; i < array_length(global.trophies); i++) {
	global.trophies[i].location = i;
}

global.collected_trophies_stack = [];

function get_trophy(image) {
	for (var i = 0; i < array_length(global.trophies); i++) {
		var trophy = global.trophies[i];
		
		if (trophy.image == image + 1) {
			return trophy;
		}
	}
	
	return null;
}

function achieve_trophy(image) {
	if (achieved_trophy(image)) {
		return;
	}
	
	var trophy = get_trophy(image);
	trophy.achieve();
	
	if (array_length(global.collected_trophies) == array_length(global.trophies) - 1) {
		achieve_trophy(79);
	}
}

function achieved_trophy(image) {
	return (array_search(global.collected_trophies, image));
}

function hint_trophy(image) {
	if (hinted_trophy(image)) {
		return;
	}
	
	var trophy = get_trophy(image);
	trophy.hint();
}

function hinted_trophy(image) {
	return (array_search(global.collected_hint_trophies, image));
}

function spoiler_trophy(image) {
	if (spoilered_trophy(image)) {
		return;
	}
	
	var trophy = get_trophy(image);
	trophy.spoiler();
}

function spoilered_trophy(image) {
	return (array_search(global.collected_spoiler_trophies, image));
}

function collect_trophy(image) {
	var trophy = get_trophy(image);
	var t = instance_create_layer(0, 0, "Managers", objCollectedTrophy);
	t.rank = trophy.rank;
	t.image = trophy.image;
	t.trophy = image;
}

function draw_trophy(x, y, trophy) {
	draw_sprite(sprTrophyCups, (achieved_trophy(trophy.image - 1)) ? trophy.rank : TrophyRank.Unknown, x, y);
	
	var image_y = y;
	
	switch (trophy.rank) {
		case TrophyRank.Platinum: image_y -= 125; break;
		case TrophyRank.Gold: image_y -= 105; break;
		case TrophyRank.Silver: image_y -= 100; break;
		case TrophyRank.Bronze: image_y -= 115; break;
	}
	
	draw_sprite(sprTrophyImages, (achieved_trophy(trophy.image - 1)) ? trophy.image : 0, x, image_y);
	draw_set_font(fntFilesData);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_text_outline(x, y - 40, string(trophy.location + 1), c_black);
	draw_set_halign(fa_left);
}

function change_collected_coins(amount) {
	if (amount == 0) {
		return;
	}
	
	var c = instance_create_layer(0, 0, "Managers", objCollectedCoins);
	c.amount = amount;
	global.collected_coins += amount;
}
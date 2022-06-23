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
	new Trophy(7, 1, "Coinless", "You went down to 0 Coins in Party...\nWelp, time to live in the streets.", "You don't wanna lose that many."),
	new Trophy(8, 2, "Memory Magician", "You scored a perfect 10 in Magic Memory.\nCan I borrow that memory of yours for a second?", "How can you keep so many items in your head?"),
	new Trophy(9, 2, "Messed Memory", "You didn't put any items in the pedestals in Magic Memory...\nAt least try!", "You can't have that bad of a memory..."),
	new Trophy(10, 2, "Tie your tie", "You obtained a Tie in a minigame.\nWelp guess no one wins anything.", "Seriously? No one wins?"),
	new Trophy(11, 2, "Flexing Ghosts", "You went back after almost reaching the light in Haunted Forest.\nNow that's just showing off.", "Spooky stuff isn't that spooky."),
	new Trophy(12, 2, "Shine Denier", "You said 'No' to the Shine.\nLeaving in darkness it is.", "I have too many, I don't need it."),
	new Trophy(13, 0, "Showdown Survivor", "You survived all 3 rounds with your team in Number Showdown.\nThat's teamwork for you! Or not?", "That was certainly a showdown teamwork."),
	new Trophy(14, 0, "Showdown Killer", "You killed the whole team in the first round in Number Showdown.\nIn cold blood.", "You better not murder the showdown."),
	new Trophy(15, 1, "Professional Escapist", "You chose only the correct doors in Mansion Escape.\nHoudini would be proud of you.", "Escaping? Piece of cake."),
	new Trophy(16, 2, "Spiky Dodger", "You dodged all of the spikes in Getting Coins.\nSquare shaped spikes are just that easy to dodge.", "I prefer triangular spikes."),
	new Trophy(17, 0, "Red Coin", "You collected a red coin in Getting Coins!\nFINALLY! The red coin in this G stage was really hard. Or wait... is this the wrong game?", "The red in G is pretty tough.")
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
			case 0: amount = 1000; break;
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
	var c = instance_create_layer(0, 0, "Managers", objCollectedCoins);
	c.amount = amount;
	global.collected_coins += amount;
}

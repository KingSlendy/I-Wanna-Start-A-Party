function BonusShine(index, text) constructor {
	self.index = index;
	self.text = text;
	
	static reset_scores = function() {
		self.scores = array_create(global.player_max, 0);
	}
	
	self.reset_scores();
	
	static increase_score = function(player_id = focused_player().network_id, amount = 1) {
		self.scores[player_id - 1] += amount;
	}
	
	static set_score = function(score, player_id = focused_player().network_id) {
		self.scores[player_id - 1] = score;
	}
	
	static is_candidate = function() {
		return (array_count(self.scores, 0) < global.player_max);
	}
	
	static max_players = function() {
		var players = [];
		var max_score = -infinity;
		
		for (var i = 0; i < global.player_max; i++) {
			max_score = max(self.scores[i], max_score);
		}
		
		for (var i = 0; i < global.player_max; i++) {
			if (self.scores[i] == max_score) {
				array_push(players, i + 1);
			}
		}
		
		return players;
	}
}

enum BonusShines {
	MostCoins,
	MostItems,
	MostMinigames,
	MostRoll,
	MostBlueSpaces,
	MostRedSpaces,
	MostGreenSpaces,
	MostItemSpaces,
	MostChanceTimeSpaces,
	MostTheGuySpaces,
	MostPurchases
}

global.bonus_shines = [
	new BonusShine(0, "got the most Coins"),
	new BonusShine(1, "used the most Items"),
	new BonusShine(2, "won the most Minigames"),
	new BonusShine(3, "rolled the biggest Numbers on the die"),
	new BonusShine(4, "landed on the most Blue spaces"),
	new BonusShine(5, "landed on the most Red spaces"),
	new BonusShine(6, "landed on the most Green spaces"),
	new BonusShine(7, "landed on the most Item spaces"),
	new BonusShine(8, "landed on the most Chance Time spaces"),
	new BonusShine(9, "landed on the most The Guy spaces"),
	new BonusShine(10, "spent the most money on the Shop")
];

global.bonus_shines_ready = array_create(global.player_max, false);

function bonus_shine_by_id(bonus_id) {
	return global.bonus_shines[bonus_id];
}
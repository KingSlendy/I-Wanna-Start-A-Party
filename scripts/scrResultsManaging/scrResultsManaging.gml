function BonusShine(sprite, index, text) constructor {
	self.sprite = sprite;
	self.index = index;
	self.text = text;
	
	static reset_scores = function() {
		self.scores = array_create(global.player_max, 0);
	}
	
	self.reset_scores();
	
	static increase_score = function(player_id = focused_player().network_id) {
		self.scores[player_id - 1]++;
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

global.bonus_shines = {
	most_coins: new BonusShine(sprCoin, 0, "got the most coins"),
	most_items: new BonusShine(sprItemItemBag, 0, "used items the most"),
	most_minigames: new BonusShine(sprModesMinigames, 0, "won the most minigames"),
	most_roll: new BonusShine(sprDie, 0, "rolled the biggest numbers on the dice"),
	most_blue_spaces: new BonusShine(sprSpaces, 0, "landed on the most Blue spaces"),
	most_red_spaces: new BonusShine(sprSpaces, 1, "landed on the most Red spaces"),
	most_green_spaces: new BonusShine(sprSpaces, 2, "landed on the most Green spaces"),
	most_item_spaces: new BonusShine(sprSpaces, 5, "landed on the most Item spaces"),
	most_chance_time_spaces: new BonusShine(sprSpaces, 7, "landed on the most Chance Time spaces"),
	most_the_guy_spaces: new BonusShine(sprSpaces, 8, "landed on the most The Guy spaces"),
	most_purchases: new BonusShine(sprShop, 0, "purchased the most items in the shop")
};

global.bonus_shines_ready = array_create(global.player_max, false);

function bonus_shine_by_id(bonus_id) {
	return global.bonus_shines[$ bonus_id];
}

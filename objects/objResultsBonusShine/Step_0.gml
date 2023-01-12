if (increase) {
	image_xscale += 0.03;
	image_yscale += 0.03;

	if (image_xscale >= 1) {
		image_xscale = 1;
		image_yscale = 1;
		increase = false;
		
		if (global.player_id == 1) {
			var times = ["The first", "The second", "And the last"];
			
			start_dialogue([
				string_interp("{0} bonus Shine goes to the one that {1}.", times[objResults.bonus_round - 1], bonus.text),
				new Message("And this goes to...",, function() {
					with (objResultsBonusShine) {
						go_up();
					}
				})
			]);
		}
	}
}
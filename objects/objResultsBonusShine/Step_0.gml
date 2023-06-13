if (increase) {
	image_xscale += 0.03;
	image_yscale += 0.03;

	if (image_xscale >= 1) {
		image_xscale = 1;
		image_yscale = 1;
		increase = false;
		
		if (global.player_id == 1) {
			var times = [language_get_text("PARTY_RESULTS_THE_FIRST"), language_get_text("PARTY_RESULTS_THE_SECOND"), language_get_text("PARTY_RESULTS_THE_LAST")];
			
			start_dialogue([
				language_get_text("PARTY_RESULTS_BONUS_GOES", times[objResults.bonus_round - 1], bonus.text),
				new Message(language_get_text("PARTY_RESULTS_GOES_TO"),, function() {
					with (objResultsBonusShine) {
						go_up();
					}
				})
			]);
		}
	}
}
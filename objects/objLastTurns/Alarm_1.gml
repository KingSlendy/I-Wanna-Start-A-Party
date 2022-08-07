if (is_local_turn()) {
	
	
	var texts = [
		"Good party everyone! It has been super fun so far, but we're nearing the end, only a couple turns left!",
		"This is the perfect time to spice things up a little bit, but first let's see how everyone is doing so far..."
	];
	
	for (var i = 1; i <= global.player_max; i++) {
		with (objPlayerInfo) {
			if (order == i) {
				var p_info = id;
				break;
			}
		}
		
		array_push(texts, new Message("{COLOR,0000FF}" + p_info.player_info.name + "{COLOR,FFFFFF} is in {SPRITE,sprPlayerInfoPlaces," + string(p_info.player_info.place - 1) + ",0,0,0.6,0.6} place."),, say_player_place);
	}
	
	array_push(texts, new Message("Looks like {COLOR,0000FF}" + p_info.player_info.name + "{COLOR,FFFFFF} is having some trouble... let's give them a little bit of help!",, help_last_place));
	start_dialogue(texts);
}
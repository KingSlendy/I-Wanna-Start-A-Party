music_check();

if (room == rTitle) {
	exit;
	start_dialogue(fntDialogue, [
		"This is a dialogue text, I hope it works okay!",
	
		new Message("A branch comes from here, do you agree?", [
			["Yes", [
				"Oh I see so you agree",
				"I'm really glad that's the case"
			]],
		
			["No", [
				"Why don't you agree?",
			
				new Message("You hate me or something?", [
					["Yes", [
						"Why???? :(",
						new Message("{COLOR,DADADA}*Goes cry into a corner*", [], function() { show_message("CRIES"); })
					]],
				
					["No", [
						"I'm glad then"
					]]
				])
			]]
		])
	], 1);
}
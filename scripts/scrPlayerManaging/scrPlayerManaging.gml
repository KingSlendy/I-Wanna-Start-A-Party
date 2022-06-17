function Skin(id, name, fangame_name, fangame_index, maker, price = 100) constructor {
	self.id = id;
	self.name = name;
	self.fangame_name = fangame_name;
	self.fangame_index = fangame_index;
	self.maker = maker;
	self.price = price;
}

global.skins = [
	new Skin("Normal", "The Kid", "I Wanna Be The Guy", 0, "Kayin", 0),
	new Skin("Crimson", "Crimson Kid", "I Wanna Be The Crimson", 1, "Carnival", 0),
	new Skin("Tribute", "Tribute Kid", "I Wanna Be The Tribute", 2, "shaman666", 0),
	new Skin("Justice", "Justice Kid", "I Wanna Be The Justice", 3, "Carnival", 0),
	new Skin("Sepia", "Sepia Kid", "Sepia Needle", 4, "Kogami Takara"),
	new Skin("Shiver", "Shiver Kid", "I Wanna Be The Shiver", 5, "PlasmaNapkin", 200),
	new Skin("Kitten", "The Kitten", "I Wanna Be The Cat", 6, "Nemega", 400),
	new Skin("Kamilia", "Kamilia", "I Wanna Kill The Kamilia", 7, "OyO", 200),
	new Skin("HappyCherry", "Happy Cherry", "I Wanna Thank You MJIWBT", 8, "PlayerDash2017", 200),
	new Skin("Ghost", "Ghost Kid", "I Wanna Spook Jam", 9, "Patrickgh3", 400),
	new Skin("Happil", "???", "I Wanna Kill The Happil", 10, "Just"),
	new Skin("Knot", "Knot", "SlimePark", 11, "Nekoroneko"),
	new Skin("Koishi", "Koishi Kid", "DEATH GRIP IS ONLINE", 12, "Razzor_iw", 900),
	new Skin("Xmas", "Xmas Kid", "Jingle Jam", 13, "Patrickgh3", 400),
	new Skin("Darth", "Darth Vader", "I Wanna Travel The Worlds", 14, "KingSlendy", 500),
	new Skin("Link", "Link", "I Wanna Travel The Worlds", 15, "KingSlendy", 500),
	new Skin("Eclipse", "Eclipse Kid", "I Wanna Eclipse", 16, "Gwiz609", 600),
	new Skin("Lockpick", "Lockpick Girl", "I Wanna Lockpick", 17, "LAWatson", 800),
	new Skin("Joker", "Joker", "I Wanna Escape And Be Free", 18, "Kogami Takara", 1000),
	new Skin("Scare", "Fairy Kid", "I Wanna Be The Scare", 19, "???", 300),
	new Skin("Dark", "Dark Kid", "I Wanna Travel The Worlds", 20, "KingSlendy"),
	new Skin("Easy", "Easy Kid", "I Wanna Be Easy!", 21, "superstarjonesbros", 300),
	new Skin("Miku", "Hatsune Miku", "I Wanna Be The Ocean Pr.", 22, "Kurath", 600),
	new Skin("Miki", "The Girl", "I Wanna Meet The Miki", 23, "riktoi", 400),
	new Skin("Producer", "Produccer Kid", "I Wanna Be THE iDOLM@STER", 24, "eden", 300),
	new Skin("Kami2", "Reimu", "I Wanna Kami2Kami2Kami2", 25, "Reimu2020", 500),
	new Skin("Baba", "Baba Is Kid", "I Wanna Stop The Simulation", 26, "RandomErik", 700),
	new Skin("Megaman", "Megaman", "I Wanna Be The Rockman", 27, "DakaArts", 700),
	new Skin("Sora", "Sora (NGNL)", "I Don't Wanna Be A Weeb", 28, "Kaurosu", 300),
	new Skin("Subaru", "Subaru", "I Don't Wanna Be A Weeb", 29, "Kaurosu", 300),
	new Skin("Whispered", "Whispered Kid", "I Wanna Whispered Treasures", 30, "Seimu", 400),
	new Skin("Hearts", "Sora (KH)", "Original", 31, "Kaurosu", 1000),
	new Skin("Aqua", "Aqua", "Original", 32, "Kaurosu", 1000),
	new Skin("Geezer", "TheNewGeezer", "I Wanna Thank You TNG", 33, "???", 200),
	new Skin("Patrick", "Patrickgh3", "I Wanna Thank You PG3", 34, "???", 200),
	new Skin("Forest", "Forest Kid", "I Wanna Be Trolled", 35, "Mauricio Juega IWBT", 200),
	new Skin("Astro", "Astro Kid", "I Wanna Be Trolled", 36, "KingSlendy", 300),
	new Skin("Diver", "Diver Kid", "I Wanna Be Trolled", 37, "KingSlendy", 400),
	new Skin("Lad", "The Lad", "I Wanna Be The Guy Gaiden", 38, "Kayin"),
	new Skin("Duck", "The Duck", "I Wanna Be The HiyokoTrap", 39, "???", 500)
];

global.skin_current = 0;

function get_skin(type = global.skin_current) {
	var skin = {};
	var poses = ["Idle", "Run", "Jump", "Fall"];
	
	for (var i = 0; i < array_length(poses); i++) {
		skin[$ poses[i]] = asset_get_index("spr" + global.skins[type].id + "Player" + poses[i]);
	}
	
	return skin;
}

function get_skin_by_sprite(sprite) {
	var name = sprite_get_name(sprite);
	var check = "";
	
	for (var i = 4; i <= string_length(name); i++) {
		check += string_char_at(name, i);
		var index = -1;
		
		for (var j = 0; j < array_length(global.skins); j++) {
			if (global.skins[j].id == check) {
				index = j;
				break;
			}
		}
		
		if (index != -1) {
			return get_skin(index);
		}
	}
	
	return sprNothing;
}

function get_skin_pose_object(object, pose) {
	if (object == null) {
		return sprNothing;
	}
	
	if (instance_exists(object)) {
		return get_skin_pose(object.sprite_index, pose);
	}
	
	return sprNothing;
}

function get_skin_pose(sprite, pose) {
	var name = sprite_get_name(sprite);
	var check = "";
	
	for (var i = 4; i <= string_length(name); i++) {
		check += string_char_at(name, i);
		
		for (var j = 0; j < array_length(global.skins); j++) {
			if (global.skins[j].id == check) {
				return asset_get_index("spr" + check + "Player" + pose);
			}
		}
	}
	
	return sprNothing;
}

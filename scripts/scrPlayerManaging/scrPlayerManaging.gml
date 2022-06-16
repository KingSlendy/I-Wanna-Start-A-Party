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
	new Skin("Crimson", "???", "I Wanna Be The Crimson", 1, "Carnival", 0),
	new Skin("Tribute", "???", "I Wanna Be The Tribute", 2, "???", 0),
	new Skin("Justice", "???", "I Wanna Be The Justice", 3, "Carnival", 0),
	new Skin("Sepia", "???", "Sepia Needle", 4, "Kogami Takara"),
	new Skin("Shiver", "???", "I Wanna Be The Shiver", 5, "???", 200),
	new Skin("Kitten", "???", "I Wanna Be The Cat", 6, "Nemega", 200),
	new Skin("Kamilia", "Kamilia", "I Wanna Kill The Kamilia", 7, "OyO", 200),
	new Skin("HappyCherry", "Happy Cherry", "I Wanna Thank You MJIWBT", 8, "PlayerDash2017", 200),
	new Skin("Ghost", "???", "I Wanna Spook Jam", 9, "???", 400),
	new Skin("Happil", "???", "I Wanna Kill The Happil", 10, "Just"),
	new Skin("Knot", "???", "SlimePark", 11, "???"),
	new Skin("Koishi", "???", "???", 12, "???", 900),
	new Skin("Xmas", "???", "???", 13, "???", 400),
	new Skin("Darth", "Darth Vader", "I Wanna Travel The Worlds", 14, "KingSlendy", 500),
	new Skin("Link", "Link", "I Wanna Travel The Worlds", 15, "KingSlendy", 500),
	new Skin("Eclipse", "???", "???", 16, "???", 600),
	new Skin("Lockpick", "Lockpick Girl", "I Wanna Lockpick", 17, "LAWatson", 800),
	new Skin("Joker", "Joker", "I Wanna Escape And Be Free", 18, "Kogami Takara", 1000),
	new Skin("Scare", "???", "I Wanna Be The Scare", 19, "???", 300),
	new Skin("Dark", "Dark Kid", "I Wanna Travel The Worlds", 20, "KingSlendy"),
	new Skin("Easy", "???", "I Wanna Be Easy", 21, "???", 300),
	new Skin("Miku", "Hatsune Miku", "???", 22, "???", 1000),
	new Skin("Miki", "???", "I Wanna Meet The Miki", 23, "???", 400),
	new Skin("Producer", "???", "???", 24, "???", 300),
	new Skin("Kami2", "???", "I Wanna Kami2Kami2Kami2", 25, "???", 500),
	new Skin("Baba", "Baba Is Kid", "I Wanna Stop The Simulation", 26, "???", 1000),
	new Skin("Megaman", "Megaman", "I Wanna Be The Rockman", 27, "DakaArts", 1000),
	new Skin("Sora", "Sora (NGNL)", "I Don't Wanna Be A Weeb", 28, "Kaurosu", 300),
	new Skin("Subaru", "Subaru", "I Don't Wanna Be A Weeb", 29, "Kaurosu", 300),
	new Skin("Whispered", "???", "???", 30, "???", 400),
	new Skin("Hearts", "Sora (KH)", "Original", 31, "Kaurosu", 1000),
	new Skin("Aqua", "Aqua", "Original", 32, "Kaurosu", 1000)
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
		var index = array_index(global.skins, check);
		
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
		
		if (array_contains(global.skins, check)) {
			return asset_get_index("spr" + check + "Player" + pose);
		}
	}
	
	return sprNothing;
}

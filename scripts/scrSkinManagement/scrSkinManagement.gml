function Skin(id, name, fangame_name, fangame_index, maker, price = 100) constructor {
	self.id = id;
	self.name = name;
	self.fangame_name = fangame_name;
	self.fangame_index = fangame_index;
	self.maker = maker;
	self.price = price;
}

global.skin_current = 0;

function skin_init() {
	global.skins = [
		new Skin("Normal", "The Kid", "I Wanna Be The Guy", 1, "Kayin", 0),
		new Skin("Crimson", "Crimson Kid", "I Wanna Be The Crimson", 2, "Carnival", 0),
		new Skin("Tribute", "Tribute Kid", "I Wanna Be The Tribute", 3, "shaman666", 0),
		new Skin("Demon", "Demon Kid", "I Wanna Be The Justice", 4, "Carnival", 0),
		new Skin("Sepia", "Sepia Kid", "Sepia Needle", 5, "Kogami Takara"),
		new Skin("Shiver", "Shiver Kid", "I Wanna Shiver", 6, "PlasmaNapkin", 200),
		new Skin("Kitten", "The Kitten", "I Wanna Be The Cat", 7, "Nemega", 400),
		new Skin("Kamilia", "Kamilia", "I Wanna Kill The Kamilia", 8, "OyO", 200),
		new Skin("HappyCherry", "Happy Cherry", "I Wanna Thank You MJIWBT", 9, "PlayerDash2017", 200),
		new Skin("Ghost", "Ghost Kid", "I Wanna Spook Jam", 10, "Patrickgh3", 400),
		new Skin("Happil", "Happil Kid", "I Wanna Kill The Happil", 11, "Just"),
		new Skin("Knot", "Knot", "SlimePark", 12, "Nekoroneko"),
		new Skin("Koishi", "Koishi Kid", "DEATH GRIPS IS ONLINE", 13, "Razzor_iw", 900),
		new Skin("Xmas", "Xmas Kid", "Jingle Jam", 14, "Patrickgh3", 400),
		new Skin("Darth", "Darth Vader", "I Wanna Travel The Worlds", 0, "KingSlendy", 500),
		new Skin("Link", "Link", "I Wanna Travel The Worlds", 0, "KingSlendy", 500),
		new Skin("Eclipse", "Eclipse Kid", "I Wanna Eclipse", 16, "Gwiz609", 600),
		new Skin("Lockpick", "Lockpick Girl", "I Wanna Lockpick", 17, "LAWatson", 800),
		new Skin("Joker", "Joker", "I Wanna Escape And Be Free", 18, "Kogami Takara", 1000),
		new Skin("Scare", "Fairy Kid", "I Wanna Be The Scare", 19, "???", 300),
		new Skin("Dark", "Dark Kid", "I Wanna Travel The Worlds", 0, "KingSlendy"),
		new Skin("Easy", "Punky", "I Wanna Be Easy!", 20, "superstarjonesbros", 300),
		new Skin("Miku", "Hatsune Miku", "I Wanna Be The Ocean Pr.", 21, "Kurath", 600),
		new Skin("Miki", "The Girl", "I Want To Meet Miki", 22, "riktoi", 400),
		new Skin("Produccer", "Produccer Kid", "I Wanna Be THE iDOLM@STER", 23, "eden", 300),
		new Skin("Kami2", "Reimu", "I Wanna Kami2Kami2Kami2", 24, "Reimu2020", 500),
		new Skin("Baba", "Baba Is Kid", "I Wanna Stop The Simulation", 25, "RandomErik", 700),
		new Skin("Megaman", "Megaman", "I Wanna Be The Rockman", 26, "DakaArts", 700),
		new Skin("Sora", "Sora (NGNL)", "I Don't Wanna Be A Weeb", 27, "Kaurosu", 300),
		new Skin("Subaru", "Subaru", "I Don't Wanna Be A Weeb", 27, "Kaurosu", 300),
		new Skin("Whispered", "Whispered Kid", "I Wanna Whispered Treasures", 28, "Seimu", 400),
		new Skin("Hearts", "Sora (KH)", "Original", 0, "Kaurosu", 1000),
		new Skin("Aqua", "Aqua", "Original", 0, "Kaurosu", 1000),
		new Skin("Geezer", "TheNewGeezer", "I Wanna Thank You TNG", 30, "Kale", 200),
		new Skin("Patrick", "Patrickgh3", "I Wanna Thank You PG3", 31, "quasiatry", 200),
		new Skin("Forest", "Forest Kid", "I Wanna Be Trolled", 0, "Mauricio Juega IWBT", 200),
		new Skin("Astro", "Astro Kid", "I Wanna Be Trolled", 0, "KingSlendy", 300),
		new Skin("Diver", "Diver Kid", "I Wanna Be Trolled", 0, "KingSlendy", 400),
		new Skin("Lad", "The Lad", "I Wanna Be The Guy Gaiden", 33, "Kayin"),
		new Skin("Duck", "The Duck", "I Wanna Be The HiyokoTrap", 34, "Ume", 500),
		new Skin("Orc", "Orc Kid", "I Wanna Be The Tribute", 3, "shaman666", 300),
		new Skin("Camouflage", "Camouflage Kid", "I Wanna Be The Tribute", 3, "shaman666", 200),
		new Skin("Robot", "Robot Kid", "I Wanna Be The Tribute", 3, "shaman666", 400),
		new Skin("Knight", "Knight Kid", "I Wanna Be The Tribute", 3, "shaman666", 500),
		new Skin("Erina", "Erina", "Erina Mou Tsuyokunatta!", 35, "Komichi Aya", 600),
		new Skin("MasterR", "MasterR", "I Wanna Be Myself", 36, "SirRouven", 400),
		new Skin("8bit", "8 Bit Kid", "I Wanna Be The 8bit", 37, "Sephalos", 500),
		new Skin("Spiritia", "Spiritia Rosenberg", "The Mage's Lair", 38, "BlueMage0", 600),
		new Skin("Glitch", "Glitch Kid", "Soulless", 39, "Redire", 400),
		new Skin("Angel", "Angel Kid", "I Wanna Be The HeavenTrap", 40, "Carnival", 400),
		new Skin("Satan", "Satan Kid", "I Wanna Be The HeavenTrap 2", 41, "Carnival", 400),
		new Skin("Farewell", "Farewell Kid", "I Wanna Be The Farewell", 42, "azure", 400),
		new Skin("Owata", "Owata", "I Wanna Be The Guy Re.", 43, "Natsu", 500),
		new Skin("Bread", "The Bread", "I Wanna Bread", 44, "Patrickgh3", 500),
		new Skin("Critic", "Critic", "I Wanna Kill The 3sweepor", 45, "RandomErik", 400),
		new Skin("Troller", "The Troller", "I Wanna Kill The 3sweepor", 45, "RandomErik", 300),
		new Skin("Explorer", "Explorer Kid", "I Wanna Be The Explorer", 46, "Hone", 200),
		new Skin("Syobon", "Syobon Cat", "Original", 0, "SergioGameMaker", 500),
		new Skin("Cute", "Cute Girl", "I Wanna Nonamed Spike 2", 47, "Mobiun", 400),
		new Skin("Stand", "Kid And Stand", "I Wanna Nonamed Spike 2", 47, "Nyinmir", 400),
		new Skin("PD", "PDPlayer Kid", "I Wanna Nonamed Spike 2", 47, "PDPlayer", 500),
		new Skin("Round", "Round Kid", "I Wanna Nonamed Spike 2", 47, "Dengol", 300),
		new Skin("Science", "Science Kid", "I Wanna Nonamed Spike 2", 47, "Mobiun", 400),
		new Skin("Soap", "Soap", "I Wanna Nonamed Spike 2", 47, "Soap", 300),
		new Skin("Orga", "Orga Itsuka", "I Wanna Can't Stop", 48, "Doruppi", 500),
		new Skin("Limit", "Hot Limit Kid", "I Wanna Can't Stop", 48, "Doruppi", 100),
		new Skin("Crush", "Crush Kid", "I Wanna Can't Stop", 48, "Doruppi", 400),
		new Skin("Tennis", "Tennis Kid", "I Wanna Can't Stop", 48, "Doruppi", 300)
	];
}

function get_skin(type = global.skin_current) {
	var skin = {};
	var poses = ["Idle", "Run", "Jump", "Fall"];
	
	for (var i = 0; i < array_length(poses); i++) {
		skin[$ poses[i]] = asset_get_index("spr" + global.skins[type].id + "Player" + poses[i]);
	}
	
	return skin;
}

function gain_skin(skin) {
	array_push(global.collected_skins, skin);
	array_sort(global.collected_skins, true);
	save_file();
}

function have_skin(skin) {
	return (array_contains(global.collected_skins, skin));
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

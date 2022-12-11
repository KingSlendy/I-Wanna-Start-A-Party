global.board_price = 5000;
global.minigame_price = 2000;
global.trial_price = 100;

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
		new Skin("Sepia", "Sepia Kid", "Sepia Needle", 5, "Kogami Takara", 0),
		new Skin("Shiver", "Shiver Kid", "I Wanna Shiver", 6, "PlasmaNapkin", 0),
		new Skin("Kitten", "The Kitten", "I Wanna Be The Cat", 7, "Nemega", 0),
		new Skin("Kamilia", "Kamilia", "I Wanna Kill The Kamilia", 8, "OyO", 0),
		new Skin("HappyCherry", "Happy Cherry", "I Wanna Thank You MJIWBT", 9, "PlayerDash2017", 200),
		new Skin("Ghost", "Ghost Kid", "I Wanna Spook Jam", 10, "Patrickgh3", 400),
		new Skin("Just", "Just", "I Wanna Kill The Happil", 11, "Just"),
		new Skin("Knot", "Knot", "SlimePark", 12, "Nekoroneko"),
		new Skin("Koishi", "Koishi Kid", "DEATH GRIPS IS ONLINE", 13, "Razzor_iw", 900),
		new Skin("Xmas", "Xmas Kid", "Jingle Jam", 14, "Patrickgh3", 400),
		new Skin("Darth", "Darth Vader", "I Wanna Travel The Worlds", 15, "KingSlendy", 500),
		new Skin("Link", "Link", "I Wanna Travel The Worlds", 15, "KingSlendy", 500),
		new Skin("Eclipse", "Eclipse Kid", "I Wanna Eclipse", 16, "Gwiz609", 600),
		new Skin("Lockpick", "Lockpick Girl", "I Wanna Lockpick", 17, "LAWatson", 800),
		new Skin("Joker", "Joker", "I Wanna Escape And Be Free", 18, "Kogami Takara", 1000),
		new Skin("Scare", "Fairy Kid", "I Wanna Be The Scare", 19, "???", 300),
		new Skin("Dark", "Dark Kid", "I Wanna Travel The Worlds", 15, "KingSlendy"),
		new Skin("Easy", "Punky", "I Wanna Be Easy!", 20, "superstarjonesbros", 300),
		new Skin("Miku", "Miku Hatsune", "I Wanna Be The Ocean Pr.", 21, "Kurath", 600),
		new Skin("Miki", "The Girl", "I Want To Meet Miki", 22, "riktoi", 400),
		new Skin("Producer", "Producer Kid", "I Wanna Be THE iDOLM@STER", 23, "eden", 300),
		new Skin("Reimu", "Reimu Hakurei", "I Wanna Kami2Kami2Kami2", 24, "Reimu2020", 500),
		new Skin("Baba", "Baba Is Kid", "I Wanna Stop The Simulation", 25, "RandomErik", 700),
		new Skin("Megaman", "Megaman", "I Wanna Be The Rockman", 26, "DakaArts", 700),
		new Skin("Sora", "Sora (NGNL)", "I Don't Wanna Be A Weeb", 27, "Kaurosu", 300),
		new Skin("Subaru", "Subaru", "I Don't Wanna Be A Weeb", 27, "Kaurosu", 300),
		new Skin("Whispered", "Whispered Kid", "I Wanna Whispered Treasures", 28, "Seimu", 400),
		new Skin("Hearts", "Sora (KH)", "Original", 29, "Kaurosu", 1000),
		new Skin("Aqua", "Aqua", "Original", 29, "Kaurosu", 1000),
		new Skin("Geezer", "TheNewGeezer", "I Wanna Thank You TNG", 30, "Kale", 200),
		new Skin("Patrick", "Patrickgh3", "I Wanna Thank You PG3", 31, "quasiatry", 200),
		new Skin("Forest", "Forest Kid", "I Wanna Be Trolled", 32, "Mauricio Juega IWBT", 200),
		new Skin("Astro", "Astro Kid", "I Wanna Be Trolled", 32, "KingSlendy", 300),
		new Skin("Diver", "Diver Kid", "I Wanna Be Trolled", 32, "KingSlendy", 400),
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
		new Skin("Troller", "The Troller", "I Wanna Kill The 3sweepor", 45, "Tralexium", 300),
		new Skin("Explorer", "Explorer Kid", "I Wanna Be The Explorer", 46, "Hone", 200),
		new Skin("Syobon", "Syobon Cat", "Original", 29, "SergioGameMaker", 400),
		new Skin("Cute", "Cute Girl", "I Wanna Nonamed Spike 2", 47, "Mobiun", 400),
		new Skin("Stand", "Kid And Stand", "I Wanna Nonamed Spike 2", 47, "Nyinmir", 400),
		new Skin("PD", "PDplayer Kid", "I Wanna Nonamed Spike 2", 47, "PDplayer", 500),
		new Skin("Round", "Round Kid", "I Wanna Nonamed Spike 2", 47, "Dengol", 300),
		new Skin("Science", "Science Kid", "I Wanna Nonamed Spike 2", 47, "Mobiun", 400),
		new Skin("Soap", "Soap", "I Wanna Nonamed Spike 2", 47, "Soap", 300),
		new Skin("Orga", "Orga Itsuka", "I Wanna Can't Stop", 48, "Doruppi", 500),
		new Skin("Limit", "Hot Limit Kid", "I Wanna Can't Stop", 48, "Doruppi", 100),
		new Skin("Crush", "Crush Kid", "I Wanna Can't Stop", 48, "Doruppi", 400),
		new Skin("Tennis", "Tennis Kid", "I Wanna Can't Stop", 48, "Doruppi", 300),
		new Skin("Migueto", "Migueto", "Original", 29, "PlayerDash2017", 500),
		new Skin("Monkey", "The Monkey", "I Wanna See You Suffer", 49, "UltraJDude", 700),
		new Skin("Crewmate", "Crewmate", "Original", 29, "JPRG666", 900),
		new Skin("Adventurer", "The Adventurer", "I Wanna Escape From The Dun.", 50, "AlejoFangamer", 1000),
		new Skin("Meiki", "Meiki", "Original", 29, "AlejoFangamer", 1000),
		new Skin("Jota", "Jota", "Original", 29, "AlejoFangamer", 1000),
		new Skin("Renex", "Renex", "Original", 29, "AlejoFangamer", 1000),
		new Skin("Void", "Void Kid", "Original", 29, "JPRG666", 1000),
		new Skin("Cuphead", "Cuphead", "Original", 29, "JPRG666", 1000),
		new Skin("Mugman", "Mugman", "Original", 29, "JPRG666", 1000),
		new Skin("Hollow", "The Knight", "Original", 29, "JPRG666", 1000),
		new Skin("Hat", "Hat Kid", "Original", 29, "JPRG666", 1000),
		new Skin("Monokuma", "Monokuma", "Original", 29, "JPRG666", 1000),
		new Skin("Lost", "The Lost", "Original", 29, "JPRG666", 1000),
		new Skin("Huse", "Huse", "Original", 29, "Kogami Takara", 800),
		new Skin("Yonaka", "Yonaka Kurai", "Original", 29, "Kogami Takara", 1000),
		new Skin("Monika", "Monika", "Original", 29, "Kaurosu", 1000),
		new Skin("Yuri", "Yuri", "Original", 29, "Kaurosu", 1000),
		new Skin("Natsuki", "Natsuki", "Original", 29, "Kaurosu", 1000),
		new Skin("Sayori", "Sayori", "Original", 29, "Kaurosu", 1000),
		new Skin("Tanjiro", "Tanjiro Kamado", "Original", 29, "JPRG666", 1000),
		new Skin("Geno", "Geno", "Original", 29, "JPRG666", 1000),
		new Skin("Kris", "Kris", "I Wanna Travel Alone", 51, "EchoMask", 600),
		new Skin("Ninja", "Ninja Kid", "Crimson Needle 2", 52, "Kale", 500),
		new Skin("Cowboy", "Cowboy Kid", "I Wanna Be The Gun Fighter", 53, "eden", 600),
		new Skin("Raiden", "Raiden", "Not Another Hentai Game", 54, "Reimu2020", 300),
		new Skin("Nightmare", "Nightmare Kamilia", "???", 55, "SquareDork", 1000),
		new Skin("Wolsk", "Wolsk", "Secret Santa For Wolsk", 56, "Kady", 500),
		new Skin("Fighter", "Fighter Kid", "I Wanna Warp The Worlds", 57, "???", 300),
		new Skin("Rock", "Rock Kid", "I Wanna Warp The Worlds", 57, "???", 500),
		new Skin("Bomb", "Bomb Kid", "I Wanna Warp The Worlds", 57, "???", 700),
		new Skin("Fire", "Fire Kid", "I Wanna Warp The Worlds", 57, "???", 900),
		new Skin("Kakkun", "Kakkun", "I Wanna Be The Cocktail", 58, "Sankakkun", 400),
		new Skin("Neko", "Neko Kid", "Avoidance Collab 4", 59, "???", 500),
		new Skin("Boshy", "Boshy", "I Wanna Be The Boshy", 60, "Solgryn", 500),
		new Skin("DarkBoshy", "Dark Boshy", "I Wanna Be The Boshy", 60, "Solgryn", 500),
		new Skin("Cirno", "Cirno", "I Wanna Plant Seeds", 61, "Lss40", 600),
		new Skin("Rotoll", "Rotoll", "I Wanna Revive The Guy", 62, "Rotoll", 100),
		new Skin("Yayoi", "Yayoi Takatsuki", "I Wanna Be The Lovely", 63, "SaunaTour", 400),
		new Skin("Marisa", "Marisa Kirisame", "Original", 0, "Harttlip0218", 500),
		new Skin("CatAngel", "Cat Angel", "Cat Planet", 0, "???", 300),
		new Skin("Best", "Best Guy Kid", "I Wanna Be The Best Guy 3", 64, "Gustav", 200),
		new Skin("Muni", "Muni", "I Wanna Defeat The Munimson", 65, "Muni", 200),
		new Skin("Heady", "Heady", "I Wanna Be The Heady", 66, "PDplayer", 300),
		new Skin("Luka", "Luka Megurine", "I Wanna Be The Ocean Pr.", 21, "Kurath", 600),
		new Skin("Gumi", "Gumi Megpoid", "I Wanna Be The Ocean Pr.", 21, "Kurath", 600),
		new Skin("Rin", "Rin Kagamine", "I Wanna Be The Ocean Pr.", 21, "Kurath", 600),
		new Skin("IA", "IA", "I Wanna Be The Ocean Pr.", 21, "Kurath", 600),
		new Skin("Solgryn", "Solgryn", "I Wanna Be The Boshy", 60, "Solgryn", 300),
		new Skin("Chair", "The Chair", "I Wanna Be The Chair 2", 67, "Stonk", 300),
		new Skin("Icy", "Icy Kid", "Icy Needle", 68, "Kogami Takara", 400),
		new Skin("Maaya", "Maaya", "I Wanna Fine-House", 69, "anxKha", 700),
		new Skin("Apple", "Apple", "I Wanna Reach The Ark", 70, "IWD", 500),
		new Skin("Yaoguo", "Yaoguo", "I Wanna Reach The Ark", 70, "IWD", 500),
		new Skin("Ermeng", "Ermeng", "I Wanna Reach The Ark", 70, "IWD", 500),
		new Skin("Toro", "Toro", "I Wanna Reach The Ark", 70, "IWD", 500),
		new Skin("Q", "Q", "I Wanna Be The Crimson Kids", 71, "IWD", 500),
		new Skin("Binggan", "Binggan", "I Wanna Be The Crimson Kids", 71, "IWD", 500),
		new Skin("Zhufeng", "Zhufeng", "I Wanna Be The Crimson Kids", 71, "IWD", 500),
		new Skin("Astronaut", "Astronaut Kid", "I Wanna VANILLA", 72, "Hanamogeta", 600),
		new Skin("Turkey", "Turkey", "I Wanna VANILLA", 72, "Hanamogeta", 700),
		new Skin("Coat", "Coat Kid", "IWBT Volatile Presence: SE", 73, "egg", 400),
		new Skin("Gummy", "Gummy Kid", "Oh, I'm A Gummy Bear", 74, "Duncan", 300),
		new Skin("Joel", "Vargkelethor Joel", "I Wanna Be The Vargskelethor", 75, "Moo Moo Armagedoon", 1000),
		new Skin("Gura", "Gawr Gura", "Original", 29, "Kogami Takara", 1000),
		new Skin("Cea", "Cea Stine", "Original", 29, "Kogami Takara", 1000),
		new Skin("ChibiMiku", "Chibi Miku", "Original", 29, "Kogami Takara", 1000),
		new Skin("Corrupted", "Corrupted Image", "Original", 29, "Kogami Takara", 100),
		new Skin("Dinosaur", "Google Dinosaur", "Original", 29, "Kogami Takara", 200),
		new Skin("ElAnpepion", "ElAnpepion", "Original", 29, "Kogami Takara", 1000),
		new Skin("Feer", "Feer", "Original", 29, "Kogami Takara", 1000),
		new Skin("Urotsuki", "Urotsuki", "Original", 29, "Kogami Takara", 1000),
		new Skin("Yui", "Yui", "Original", 29, "Kogami Takara", 1000),
		new Skin("Herz", "Herz", "Original", 29, "Kogami Takara", 1000),
		new Skin("Marvin", "Marvin The Martian", "Original", 29, "Kogami Takara", 1000),
		new Skin("Kunikida", "Kunikida Hanamaru", "Original", 29, "Kogami Takara", 1000),
		new Skin("Kagami", "Kagami Hiiragi", "Original", 29, "Kogami Takara", 1000),
		new Skin("Miyuki", "Miyuki Takara", "Original", 29, "Kogami Takara", 1000),
		new Skin("Luffy", "Monkey D. Luffy", "Original", 29, "Kogami Takara", 1000),
		new Skin("Mecha", "Mecha Kid", "Original", 29, "Kogami Takara", 1000),
		new Skin("Sherlock", "Sherlock Shellingford", "Original", 29, "Kogami Takara", 1000),
		new Skin("Luna", "Luna Rurine", "Original", 29, "PlayerDash2017", 600),
		new Skin("Crane", "Crane Kid", "Un Ange Et Un Crane", 76, "Yukii", 400),
		new Skin("SnowCoat", "Snow Coat Kid", "Jingle Jam", 14, "AlejoFangamer", 500),
		new Skin("Skuldafn", "Skuldafn", "Original", 29, "Kogami Takara", 1000),
		new Skin("JGB", "JGB", "Original", 29, "Kogami Takara", 500),
		new Skin("Alejo", "AlejoFangamer", "Original", 29, "Kogami Takara", 900),
		new Skin("PlayerDash", "PlayerDash2017", "Original", 29, "AlejoFangamer", 1000),
		new Skin("Kogami", "Kogami Takara", "Original", 29, "Kogami Takara", 1000),
		new Skin("Don", "Don-chan", "Original", 29, "Kogami Takara", 1000),
		new Skin("Boyfriend", "Boyfriend", "Original", 29, "Kogami Takara", 1000),
		new Skin("Melodii", "Melodii", "Original", 29, "Kogami Takara", 1000)
	];
}

function gain_skin(skin) {
	array_push(global.collected_skins, skin);
	array_sort(global.collected_skins, true);
	save_file();
}

function have_skin(skin) {
	return (array_search(global.collected_skins, skin));
}

function get_skin_poses() {
	return ["Idle", "Run", "Jump", "Fall"];
}

function get_skin(type = global.skin_current) {
	var skin = {};
	var poses = get_skin_poses();
	
	for (var i = 0; i < array_length(poses); i++) {
		skin[$ poses[i]] = asset_get_index("spr" + global.skins[type].id + "Player" + poses[i]);
	}
	
	return skin;
}

function get_skin_index_by_sprite(sprite) {
	if (sprite == sprPlayerBlank) {
		return null;
	}
	
	var name = sprite_get_name(sprite);
	var poses = get_skin_poses();
	var pose = null;
		
	for (var i = 0; i < array_length(poses); i++) {
		if (string_count(poses[i], name) > 0) {
			pose = poses[i];
			break;
		}
	}
	
	if (pose == null) {
		return null;
	}
	
	var check = string_copy(name, 4, string_length(name) - 9 - string_length(pose));
	
	for (var i = 0; i < array_length(global.skins); i++) {
		if (global.skins[i].id == check) {
			return i;
		}
	}
	
	return null;
}

function get_skin_by_sprite(sprite) {
	return get_skin(get_skin_index_by_sprite(sprite)) ?? sprNothing;
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
	var index = get_skin_index_by_sprite(sprite);
	
	if (index == null) {
		return sprNothing;
	}

	return get_skin(index)[$ pose];
}

function Reaction(name, sound, maker, price = 100) constructor {
	self.name = name;
	self.sound = sound;
	self.maker = maker;
	self.price = price;
	self.index = -1;
}

function reaction_init() {
	global.reactions = [
		new Reaction("Kid Smile", null, "AliceNobodi"),
		new Reaction("Kid Run", null, "AliceNobodi"),
		new Reaction("Guy Rage", null, "AliceNobodi"),
		new Reaction("Kid Pog", null, "AliceNobodi", 200),
		new Reaction("Kid Pain", null, "AliceNobodi", 200),
		new Reaction("Miku Shock", null, "AliceNobodi", 300),
		new Reaction("Colonel Moment", null, "AliceNobodi"),
		new Reaction("Mayumushi Hi", null, "AliceNobodi"),
		new Reaction("Kid Falling", null, "AliceNobodi", 200),
		new Reaction("Kid Highroll", null, "AliceNobodi", 300),
		new Reaction("Kid Balance", null, "PlayerDash2017", 200),
		new Reaction("Dracula Fail", null, "PlayerDash2017"),
		new Reaction("Kid Millionare", null, "Kogami Takara", 200),
		new Reaction("The Monkey", null, "AlejoFangamer", 300),
		new Reaction("Cool Cherry", null, "AlejoFangamer", 300),
		new Reaction("Kid Nerd", null, "AliceNobodi", 300),
		new Reaction("Geezer Unamused", null, "AliceNobodi"),
		new Reaction("Kid Sleeping", null, "PlayerDash2017", 300)
	];
	
	for (var i = 0; i < array_length(global.reactions); i++) {
		global.reactions[i].index = i;
	}
}

function gain_reaction(react) {
	array_push(global.collected_reactions, react);
	array_sort(global.collected_reactions, true);
	save_file();
}

function have_reaction(react) {
	return (array_search(global.collected_reactions, react));
}
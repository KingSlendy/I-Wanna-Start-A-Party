function Minigame(title, label, instructions, preview, scene, fangame_name) constructor {
	self.title = title;
	self.label = label;
	self.instructions = instructions;
	self.preview = preview;
	self.scene = scene;
	self.fangame_name = fangame_name;
	
	var w = sprite_get_width(sprMinigameOverview_Preview);
	var h = sprite_get_height(sprMinigameOverview_Preview);
	var w_half = floor(w / 2);
	var h_half = floor(h / 2);
	var p_surf = surface_create(w, h);
	surface_set_target(p_surf);
	draw_sprite(sprMinigameOverview_Preview, 1, w_half, h_half);
	gpu_set_colorwriteenable(true, true, true, false);
	draw_sprite_stretched(sprMinigameOverview_Pictures, self.preview, 44, 15, w - 88, h - 31);
	gpu_set_colorwriteenable(true, true, true, true);
	draw_sprite(sprMinigameOverview_Preview, 0, w_half, h_half);
	surface_reset_target();
	self.portrait = sprite_create_from_surface(p_surf, 0, 0, w, h, false, false, w_half, h_half);

	surface_set_target(p_surf);
	draw_clear_alpha(c_black, 0);
	draw_sprite(sprMinigameOverview_Preview, 1, w_half, h_half);
	gpu_set_colorwriteenable(true, true, true, false);
	draw_sprite_stretched(sprMinigameOverview_Pictures, 0, 44, 15, w - 88, h - 31);
	gpu_set_colorwriteenable(true, true, true, true);
	draw_sprite(sprMinigameOverview_Preview, 0, w_half, h_half);
	surface_reset_target();
	self.hidden = sprite_create_from_surface(p_surf, 0, 0, w, h, false, false, w_half, h_half);
	surface_free(p_surf);
}

global.minigames = {};

#region Names
#region 4vs
#macro FOLLOW_THE_LEAD "Follow The Lead"
#macro TOWER_ASCENSION "Tower Ascension"
#macro HAUNTED_FOREST "Haunted Forest"
#macro MAGIC_MEMORY "Magic Memory"
#macro MANSION_ESCAPE "Mansion Escape"
#macro PAINTING_PLATFORMS "Painting Platforms"
#macro BUGS_AROUND "Bugs Around"
#macro UNSTABLE_BLOCKS "Unstable Blocks"
#macro CRAZY_CHESTS "Crazy Chests"
#macro SLIME_ANNOYER "Slime Annoyer"
#macro ROCKET_IGNITION "Rocket Ignition"
#macro DIZZY_CONUNDRUM "Dizzy Conundrum"
#macro TARGETING_TARGETS "Targeting Targets"
#macro UNCERTAIN_BULLETS "Uncertain Bullets"
#macro DRAWN_KEYS "Drawn Keys"
#macro BUBBLE_DERBY "Bubble Derby"
#macro WHAC_AN_IDOL "Whac-an-idol"
#macro SKY_DIVING "Sky Diving"
#macro GOLF_COURSE "Golf Course"
#macro WAKA_EVASION "Waka Evasion"
#endregion

#region 1vs3
#macro AVOID_THE_ANGUISH "Avoid The Anguish"
#macro CONVEYOR_HAVOC "Conveyor Havoc"
#macro NUMBER_SHOWDOWN "Number Showdown"
#macro GETTINGS_COINS "Getting Coins"
#macro GIGANTIC_RACE "Gigantic Race"
#macro WARPING_UP "Warping Up"
#macro HUNT_TROUBLE "Hunt Trouble"
#macro AIMING_TILES "Aiming Tiles"
#macro HIDDEN_HOST "Hidden Host"
#macro BAD_HOUSE "Bad House"
#endregion

#region 2vs2
#macro A_MAZE_ING "A-Maze-Ing"
#macro CATCH_THE_FRUITS "Catch The Fruits"
#macro BUTTONS_EVERYWHERE "Buttons Everywhere"
#macro FITTING_SQUARES "Fitting Squares"
#macro COLORFUL_INSANITY "Colorful Insanity"
#macro SPRINGING_PIRANHA "Springing Piranha"
#macro DYNYAAMIC_DUOS "Dynyaamic Duos"
#macro WESTERN_DUEL "Western Duel"
#macro SOCCER_MATCH "Soccer Match"
#macro JINGLE_SLEDGE "Jingle Sledge"
#endregion
#endregion

function minigame_init() {
	var m = global.minigames;
	m[$ "4vs"] = [
		new Minigame(FOLLOW_THE_LEAD, language_get_text("MINIGAMES_LEAD_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_LEAD_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_LEAD_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.down), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 2, rMinigame4vs_Lead, "I Wanna Be The Boshy"),
		new Minigame(TOWER_ASCENSION, language_get_text("MINIGAMES_TOWER_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_TOWER_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_TOWER_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right))) DESC_END], 4, rMinigame4vs_Tower, "I Wanna Be The Guy"),
		new Minigame(HAUNTED_FOREST, language_get_text("MINIGAMES_HAUNTED_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_HAUNTED_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_HAUNTED_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right))) DESC_END], 8, rMinigame4vs_Haunted, "I Wanna Kill The Guy"),
		new Minigame(MAGIC_MEMORY, language_get_text("MINIGAMES_MAGIC_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_MAGIC_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_MAGIC_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 9, rMinigame4vs_Magic, "Not Another Magic Tower Game"),
		new Minigame(MANSION_ESCAPE, language_get_text("MINIGAMES_MANSION_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_MANSION_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_MANSION_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.up))) DESC_END], 10, rMinigame4vs_Mansion, "Kid World"),
		new Minigame(PAINTING_PLATFORMS, language_get_text("MINIGAMES_PLATFORMS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_PLATFORMS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_PLATFORMS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 16, rMinigame4vs_Painting, "I Wanna Thank You Mauricio Juega IWBT"),
		new Minigame(BUGS_AROUND, language_get_text("MINIGAMES_BUGS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_BUGS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_BUGS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right))) DESC_END], 17, rMinigame4vs_Bugs, "I Wanna Delete The Huge Bug"),
		new Minigame(UNSTABLE_BLOCKS, language_get_text("MINIGAMES_BLOCKS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_BLOCKS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_BLOCKS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 18, rMinigame4vs_Blocks, "I Wanna Thank You TheNewGeezer"),
		new Minigame(CRAZY_CHESTS, language_get_text("MINIGAMES_CHESTS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_CHESTS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_CHESTS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.up))) DESC_END], 19, rMinigame4vs_Chests, "I Wanna Be The Fangame"),
		new Minigame(SLIME_ANNOYER, language_get_text("MINIGAMES_SLIME_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"),	language_get_text("MINIGAMES_SLIME_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_SLIME_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 23, rMinigame4vs_Slime, "SlimePark"),
		new Minigame(ROCKET_IGNITION, language_get_text("MINIGAMES_ROCKET_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_ROCKET_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_ROCKET_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.shoot))) DESC_END], 24, rMinigame4vs_Rocket, "I Wanna Walk Out In The Morning Dew"),
		new Minigame(DIZZY_CONUNDRUM, language_get_text("MINIGAMES_DIZZY_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_DIZZY_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_DIZZY_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 25, rMinigame4vs_Dizzy, "VoVoVo"),
		new Minigame(TARGETING_TARGETS, language_get_text("MINIGAMES_TARGETS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"),	language_get_text("MINIGAMES_TARGETS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_TARGETS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 27, rMinigame4vs_Targets, "I Wanna Be The Micromedley"),
		new Minigame(UNCERTAIN_BULLETS, language_get_text("MINIGAMES_BULLETS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_BULLETS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_BULLETS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 30, rMinigame4vs_Bullets, "I Wanna Be A Big Man"),
		new Minigame(DRAWN_KEYS, language_get_text("MINIGAMES_DRAWN_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_DRAWN_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_DRAWN_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 31, rMinigame4vs_Drawn, "I Wanna Be Drawn"),
		new Minigame(BUBBLE_DERBY, language_get_text("MINIGAMES_BUBBLE_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_BUBBLE_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_BUBBLE_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right))) DESC_END], 36, rMinigame4vs_Bubble, "I Wanna Enjoy The Excursion"),
		new Minigame(SKY_DIVING, language_get_text("MINIGAMES_SKY_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_SKY_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_SKY_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right))) DESC_END], 38, rMinigame4vs_Sky, "I Wanna Kill The Kamilia"),
		new Minigame(GOLF_COURSE, language_get_text("MINIGAMES_GOLF_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_GOLF_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_GOLF_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 39, rMinigame4vs_Golf, "I Wanna Run The Marathon"),
		new Minigame(WAKA_EVASION, language_get_text("MINIGAMES_WAKA_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_WAKA_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_WAKA_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right))) DESC_END], 40, rMinigame4vs_Waka, "I Wanna Be The Onelife"),
		new Minigame(JINGLE_SLEDGE, language_get_text("MINIGAMES_JINGLE_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_JINGLE_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_JINGLE_PAGE_2", draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 35, rMinigame4vs_Jingle, "Jingle Jam")
	];

	m[$ "1vs3"] = [
		new Minigame(AVOID_THE_ANGUISH, language_get_text("MINIGAMES_AVOID_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"),	language_get_text("MINIGAMES_AVOID_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_AVOID_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_AVOID_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 5, rMinigame1vs3_Avoid, "I Wanna Be The Lucky"),
		new Minigame(CONVEYOR_HAVOC, language_get_text("MINIGAMES_CONVEYOR_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"), language_get_text("MINIGAMES_CONVEYOR_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_CONVEYOR_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_CONVEYOR_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 7, rMinigame1vs3_Conveyor, "Not Another Needle Game"),
		new Minigame(NUMBER_SHOWDOWN, language_get_text("MINIGAMES_SHOWDOWN_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"), language_get_text("MINIGAMES_SHOWDOWN_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_SHOWDOWN_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_SHOWDOWN_PAGE_3", draw_action(global.actions.jump), draw_action(global.actions.left), draw_action(global.actions.right))) DESC_END], 11, rMinigame1vs3_Showdown, "I Wanna Be The Showdown"),
		new Minigame(GETTINGS_COINS, language_get_text("MINIGAMES_COINS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_COINS_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_COINS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 13, rMinigame1vs3_Coins, "I Wanna Get The Coins"),
		new Minigame(GIGANTIC_RACE, language_get_text("MINIGAMES_RACE_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"),	language_get_text("MINIGAMES_RACE_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_RACE_PAGE_2")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_RACE_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 15, rMinigame1vs3_Race, "I Wanna Kill The Kamilia 2"),
		new Minigame(WARPING_UP, language_get_text("MINIGAMES_WARPING_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"), language_get_text("MINIGAMES_WARPING_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_WARPING_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_WARPING_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.shoot))) DESC_END], 22, rMinigame1vs3_Warping, "I Wanna GameOver"),
		new Minigame(HUNT_TROUBLE, language_get_text("MINIGAMES_HUNT_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"), language_get_text("MINIGAMES_HUNT_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_HUNT_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS_SOLO_PLAYER"), language_get_text("MINIGAMES_HUNT_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS_TEAM_PLAYERS"), language_get_text("MINIGAMES_HUNT_PAGE_4", draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right), draw_action(global.actions.shoot))) DESC_END], 26, rMinigame1vs3_Hunt, "I Wanna Be The Ultimatum"),
		new Minigame(AIMING_TILES, language_get_text("MINIGAMES_AIMING_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"), language_get_text("MINIGAMES_AIMING_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_AIMING_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_AIMING_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.shoot))) DESC_END], 32, rMinigame1vs3_Aiming, "I Wanna Be The Farewell"),
		new Minigame(HIDDEN_HOST, language_get_text("MINIGAMES_HOST_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"), language_get_text("MINIGAMES_HOST_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_HOST_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_HOST_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.up))) DESC_END], 33, rMinigame1vs3_Host, "I Wanna Escape Heavenly Host"),
		new Minigame(BAD_HOUSE, language_get_text("MINIGAMES_HOUSE_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES_SOLO_PLAYER"),	language_get_text("MINIGAMES_HOUSE_PAGE_1", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_RULES_TEAM_PLAYERS"), language_get_text("MINIGAMES_HOUSE_PAGE_2", "{COLOR,0000FF}", "{COLOR,FFFFFF}")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_HOUSE_PAGE_3", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 34, rMinigame1vs3_House, "Crimson Needle 3")
	];

	m[$ "2vs2"] = [
		new Minigame(A_MAZE_ING, language_get_text("MINIGAMES_MAZE_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_MAZE_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_MAZE_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 1, rMinigame2vs2_Maze, "I Wanna Kill The Kamilia 3"),
		new Minigame(CATCH_THE_FRUITS, language_get_text("MINIGAMES_FRUITS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_FRUITS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_FRUITS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right))) DESC_END], 6, rMinigame2vs2_Fruits, "I Wanna Be The Aura"),
		new Minigame(BUTTONS_EVERYWHERE, language_get_text("MINIGAMES_BUTTONS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_BUTTONS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_BUTTONS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 3, rMinigame2vs2_Buttons, "I Wanna Destroy The 6 Players"),
		new Minigame(FITTING_SQUARES, language_get_text("MINIGAMES_SQUARES_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_SQUARES_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_SQUARES_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right))) DESC_END], 12, rMinigame2vs2_Squares, "I Wanna Reach The Moon"),
		new Minigame(COLORFUL_INSANITY, language_get_text("MINIGAMES_COLORFUL_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_COLORFUL_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_COLORFUL_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 14, rMinigame2vs2_Colorful, "I Wanna Be A Charr"),
		new Minigame(SPRINGING_PIRANHA, language_get_text("MINIGAMES_SPRINGING_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_SPRINGING_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_SPRINGING_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 20, rMinigame2vs2_Springing, "I Wanna Be The Co-op"),
		new Minigame(DYNYAAMIC_DUOS, language_get_text("MINIGAMES_DUOS_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_DUOS_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_DUOS_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump), draw_action(global.actions.shoot))) DESC_END], 21, rMinigame2vs2_Duos, "I Wannyaaaaaaa"),
		new Minigame(WESTERN_DUEL, language_get_text("MINIGAMES_DUEL_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_DUEL_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_DUEL_PAGE_2", draw_action(global.actions.shoot))) DESC_END], 28, rMinigame2vs2_Duel, "I Wanna Be The Galaxy"),
		new Minigame(SOCCER_MATCH, language_get_text("MINIGAMES_SOCCER_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_SOCCER_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_SOCCER_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.right), draw_action(global.actions.jump))) DESC_END], 29, rMinigame2vs2_Soccer, "I Wanna Be The GReeeeN"),
		new Minigame(WHAC_AN_IDOL, language_get_text("MINIGAMES_IDOL_NAME"), [DESC_START draw_page(language_get_text("MINIGAMES_RULES"), language_get_text("MINIGAMES_IDOL_PAGE_1")) DESC_END, DESC_START draw_page(language_get_text("MINIGAMES_CONTROLS"), language_get_text("MINIGAMES_IDOL_PAGE_2", draw_action(global.actions.left), draw_action(global.actions.up), draw_action(global.actions.down), draw_action(global.actions.right), draw_action(global.actions.shoot))) DESC_END], 37, rMinigame2vs2_Idol, "I Wanna Be The iDOLM@STER")
	];
}

function minigame_types() {
	return ["4vs", "1vs3", "2vs2"];
}

function minigame_by_title(title) {
	var types = minigame_types();
	
	for (var i = 0; i < array_length(types); i++) {
		var type = types[i];
		var minigames = global.minigames[$ type];
		
		for (var j = 0; j < array_length(minigames); j++) {
			var minigame = minigames[j];
			
			if (minigame.title == title) {
				return [minigame, type];
			}
		}
	}
	
	return null;
}

function minigame_seen(title) {
	return (array_contains(global.seen_minigames, title));	
}

function minigame_unlock(title) {
	if (!minigame_seen(title)) {
		array_push(global.seen_minigames, title);
	}
	
	if (array_length(global.seen_minigames) == array_length(global.minigames[$ "4vs"]) + array_length(global.minigames[$ "1vs3"]) + array_length(global.minigames[$ "2vs2"])) {
		achieve_trophy(64);
	}
	
	save_file();
}

function minigame_info_reset() {
	global.minigame_info = {
		reference: null,
		type: "",
		player_colors: [],
		is_practice: false,
		is_finished: false,
		is_minigames: false,
		is_trials: false,
		
		previous_board: null,
		player_positions: [],
		space_indexes: [],
		shine_positions: [],
		
		//World Board
		ghost_position: {},
	}
	
	minigame_info_score_reset();
}

function minigame_info_score_reset() {
	var info = global.minigame_info;
	info.player_scores = [];
	info.players_won = [];
	info.is_finished = false;
	info.calculated = false;
	
	repeat (global.player_max) {
		array_push(info.player_scores, {
			ready: false,
			timer: 0,
			points: 0
		});
	}
}

function minigame_info_set(reference, type, team) {
	minigame_info_reset();
	var info = global.minigame_info;
	info.reference = reference;
	info.type = type;
				
	if (info.type != "1vs3") {
		info.player_colors = [c_blue, c_red];
	} else {
		info.player_colors = [c_red, c_blue];
	}
				
	for (var i = 1; i <= global.player_max; i++) {
		spawn_player_info(i, i);
	}	
		
	with (objPlayerInfo) {
		player_info.space = (array_contains(team, player_info.network_id)) ? c_blue : c_red;
		target_draw_x = draw_x;
		target_draw_y = draw_y;
	}
}

enum CameraMode {
	Static,
	Follow,
	Split4,
	Center
}

function players_start() {
	with (objPlayerBase) {
		change_to_object(other.player_type);
	}
	
	with (objPlayerBase) {
		xstart = x;
		ystart = y;
		event_perform(ev_other, ev_room_start);
		frozen = true;
	}
	
	minigame_players();
	
	for (var i = 0; i < array_length(points_teams); i++) {
		for (var j = 0; j < array_length(points_teams[i]); j++) {
			objMinigameController.points_teams[i][j] = focus_player_by_turn(objMinigameController.points_teams[i][j]);
		}
	}
}

function minigame4vs_start(info, mode = CameraMode.Static) {
	player_4vs_positioning();
	players_start();
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		case CameraMode.Split4: camera4vs_split4(camera_start(objCameraSplit4)); break;
		case CameraMode.Center: camera_start(objCameraCenter); break;
	}
}

function minigame1vs3_start(info, mode = CameraMode.Static) {
	player_1vs3_positioning(info);
	players_start();
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		case CameraMode.Split4: camera4vs_split4(camera_start(objCameraSplit4)); break;
		case CameraMode.Center: camera_start(objCameraCenter); break;
	}
}

function minigame2vs2_start(info, mode = CameraMode.Static) {
	player_2vs2_positioning(info);
	players_start();
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		case CameraMode.Split4: camera2vs2_split4(camera_start(objCameraSplit4), info); break;
	}
	
	player_2vs2_teammate();
}

function player_4vs_positioning() {
	objMinigameController.points_teams = [[], [], [], []];
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		
		with (objPlayerReference) {
			if (reference == i - 1) {
				player.x = x + 17;
				player.y = y + 23;
				array_push(objMinigameController.points_teams[i - 1], i);
				break;
			}
		}
	}
}

function player_1vs3_positioning(info) {
	objMinigameController.points_teams = [[], []];
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		var player_info = player_info_by_turn(i);
		
		if (player_info.space == info.player_colors[1]) {
			with (objPlayerReference) {
				if (reference == 0) {
					player.x = x + 17;
					player.y = y + 23;
					array_push(objMinigameController.points_teams[0], i);
					break;
				}
			}
		}
	}
	
	var index = 1;
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		var player_info = player_info_by_turn(i);
		
		if (player_info.space == info.player_colors[0]) {
			with (objPlayerReference) {
				if (reference == index) {
					player.x = x + 17;
					player.y = y + 23;
					index++;
					array_push(objMinigameController.points_teams[1], i);
					break;
				}
			}
		}
	}
}

function player_2vs2_positioning(info) {
	objMinigameController.points_teams = [[], []];
	var index = 0;
	
	for (var j = 0; j < array_length(info.player_colors); j++) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_turn(i);
			var player_info = player_info_by_turn(i);
		
			if (player_info.space == info.player_colors[j]) {
				with (objPlayerReference) {
					if (reference == index) {
						player.x = x + 17;
						player.y = y + 23;
						index++;
						array_push(objMinigameController.points_teams[j], i);
						break;
					}
				}
			}
		}
	}
}

function player_2vs2_teammate() {
	with (objPlayerBase) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_turn(i);
			
			if (player.id == id) {
				continue;
			}
			
			if (player_info_by_id(player.network_id).space == player_info_by_id(network_id).space) {
				teammate = player.id;
				break;
			}
		}
	}
}

function minigame_add_timer(info, player_id) {
	if (!info.is_finished && is_player_local(player_id + 1)) {
		var scoring = info.player_scores[player_id];
		
		if (!scoring.ready) {
			scoring.timer++;
		}
	}
}

function minigame_max_points() {
	return get_frames(1000000);
}

function minigame4vs_points(player_id, points = minigame_max_points()) {
	var info = global.minigame_info;
	
	if (!info.is_finished) {
		var scoring = info.player_scores[player_id - 1];
		
		if (!scoring.ready) {
			scoring.points += points;
		}
	}
}

function minigame4vs_set_points(player_id, points = minigame_max_points()) {
	var info = global.minigame_info;
	
	if (!info.is_finished) {
		var scoring = info.player_scores[player_id - 1];
		
		if (!scoring.ready) {
			scoring.points = points;
		}
	}
}

function minigame4vs_get_points(player_id) {
	var info = global.minigame_info;
	return info.player_scores[player_id - 1].points;
}

function minigame4vs_get_max_points() {
	var max_points = -infinity;
	
	for (var i = 1; i <= global.player_max; i++) {
		max_points = max(max_points, minigame4vs_get_points(i));
	}
	
	return max_points;
}

function minigame1vs3_points(points = minigame_max_points()) {
	for (var i = 0; i < minigame1vs3_team_length(); i++) {
		minigame4vs_points(minigame1vs3_team(i).network_id, points);
	}
}

function minigame2vs2_points(player_id1, player_id2, points = minigame_max_points()) {
	minigame4vs_points(player_id1, points);
	minigame4vs_points(player_id2, points);
}

function minigame2vs2_set_points(player_id1, player_id2, points = minigame_max_points()) {
	minigame4vs_set_points(player_id1, points);
	minigame4vs_set_points(player_id2, points);
}

function minigame2vs2_get_points(player_id1, player_id2) {
	return minigame4vs_get_points(player_id1) + minigame4vs_get_points(player_id2);
}

function minigame2vs2_get_points_team(team) {
	return minigame2vs2_get_points(minigame2vs2_team(team, 0).network_id, minigame2vs2_team(team, 1).network_id);	
}

function minigame_finish(signal = false) {
	with (objMinigameController) {
		action_end();
		alarm_stop(10);
		alarm_stop(11);
		
		if (info.calculated) {
			return;
		}
		
		if (!info.is_finished) {
			objPlayerBase.frozen = true;
			show_popup(language_get_text("MINIGAMES_FINISH"));
			announcer_finished = true;
			audio_play_sound(sndMinigameFinish, 0, false);
			music_stop();
			info.is_finished = true;
			
			for (var i = 1; i <= global.player_max; i++) {
				if (is_player_local(i)) {
					buffer_seek_begin();
					buffer_write_action(ClientTCP.MinigameFinish);
					buffer_write_data(buffer_u8, i);
					var scoring = info.player_scores[i - 1];
					scoring.ready = true;
					buffer_write_data(buffer_s32, scoring.timer);
					buffer_write_data(buffer_s32, scoring.points);
					var player_info = player_info_by_id(i);
					buffer_write_data(buffer_u16, player_info.shines);
					buffer_write_data(buffer_u16, player_info.coins);
					buffer_write_data(buffer_bool, signal);
					network_send_tcp_packet();
				}
			}
		}
		
		for (var i = 0; i < global.player_max; i++) {
			if (!info.player_scores[i].ready) {
				return;
			}
		}
		
		switch (info.type) {
			case "4vs": minigame4vs_winner(); break;
			case "1vs3": minigame1vs3_winner(); break;
			case "2vs2": minigame2vs2_winner(); break;
		}
			
		info.calculated = true;
		alarm_call(2, 2);
	}
}

function minigame4vs_winner() {
	var info = global.minigame_info;
	var max_score = -infinity;
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		max_score = max(max_score, scoring.points);
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var scoring = info.player_scores[i - 1];
		
		if (scoring.points == max_score) {
			array_push(info.players_won, i);
		}
	}
}

function minigame1vs3_winner() {
	var info = global.minigame_info;
	var scores = array_create(2, 0);
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[1])] += scoring.points;
	}
	
	if (scores[0] == scores[1]) {
		//Both teams have tied
		var color_won = c_white;
	} else {
		//Determines which team color wins
		var color_won = info.player_colors[(scores[1] > scores[0])];
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var color = player_info_by_id(i).space;
			
		if (color == color_won) {
			array_push(info.players_won, i);
		}
	}
}

function minigame2vs2_winner() {
	var info = global.minigame_info;
	var scores = array_create(2, 0);
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[1])] += scoring.points;
	}
	
	if (scores[0] == scores[1]) {
		//Both teams have tied
		var color_won = c_white;
	} else {
		//Determines which team color wins
		var color_won = info.player_colors[(scores[1] > scores[0])];
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var color = player_info_by_id(i).space;
			
		if (color == color_won) {
			array_push(info.players_won, i);
		}
	}
}

function minigame_times_up() {
	show_popup(language_get_text("MINIGAMES_TIMES_UP"));
	audio_play_sound(sndMinigameTimesUp, 0, false);
	music_stop();
}

function minigame_lost_all(count_last = false) {
	if (!count_last && (trial_is_title(RAPID_ASCENSION) || trial_is_title(WAKA_DODGES))) {
		return false;
	}
	
	var lost_count = 0;

	with (objPlayerBase) {
		lost_count += lost;
	}
	
	var count = (!count_last) ? global.player_max - 1 : global.player_max;
	return (lost_count >= count);
}

function minigame_lost_points() {
	with (objPlayerBase) {
		if (lost) {
			continue;
		}
		
		minigame4vs_points(network_id);
	}
}

function minigame1vs3_lost() {
	for (var i = 0; i < minigame1vs3_team_length(); i++) {
		if (!minigame1vs3_team(i).lost) {
			return false;
		}
	}
	
	return true;
}

function minigame1vs3_team_length() {
	return array_length(objMinigameController.points_teams[1]);
}

function minigame1vs3_team(num) {
	return objMinigameController.points_teams[1][num];
}

function minigame1vs3_solo() {
	return objMinigameController.points_teams[0][0];
}

function minigame1vs3_is_solo(player_id) {
	return (minigame1vs3_solo().network_id == player_id);
}

function minigame2vs2_team(team, num) {
	return objMinigameController.points_teams[team][num];
}

function minigame2vs2_is_team(player_id, num) {
	return (player_id == minigame2vs2_team(num, 0).network_id || player_id == minigame2vs2_team(num, 1).network_id);
}

function minigame_has_won() {
	return (array_length(objMinigameController.info.players_won) > 0 && array_contains(objMinigameController.info.players_won, global.player_id) && objMinigameController.info.player_scores[global.player_id - 1].points > 0);
}

function minigame_angle_dir8(actions, angle, frames = irandom_range(3, 6)) {
	switch (round(angle / 45) % 8) {
		case 0:
			actions.right.hold(frames);
			break;
					
		case 1:
			actions.up.hold(frames);
			actions.right.hold(frames);
			break;
					
		case 2:
			actions.up.hold(frames);
			break;
					
		case 3:
			actions.up.hold(frames);
			actions.left.hold(frames);
			break;
					
		case 4:
			actions.left.hold(frames);
			break;
					
		case 5:
			actions.down.hold(frames);
			actions.left.hold(frames);
			break;
					
		case 6:
			actions.down.hold(frames);
			break;
					
		case 7:
			actions.down.hold(frames);
			actions.right.hold(frames);
			break;
	}
}
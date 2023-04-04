function Minigame(title, instructions, preview, scene, fangame_name) constructor {
	self.title = title;
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
#macro DINNYAMIC_DUOS "Dinnyamic Duos"
#macro WESTERN_DUEL "Western Duel"
#macro SOCCER_MATCH "Soccer Match"
#macro JINGLE_SLEDGE "Jingle Sledge"
#endregion
#endregion

function minigame_init() {
	var m = global.minigames;
	m[$ "4vs"] = [
		new Minigame(FOLLOW_THE_LEAD, [DESC_START draw_page("Rules", "DeDeDe shows a sequence of four actions that you need to perform. Upon doing so successfully add one more action for the next player! Have in mind that you can't perform the same action twice in a row.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Direction\n" + draw_action(global.actions.jump) + " Jump\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 2, rMinigame4vs_Lead, "I Wanna Be The Boshy"),
		new Minigame(TOWER_ASCENSION, [DESC_START draw_page("Rules", "A platform that increases speed overtime\nis ascending the tower!\nAvoid the spikes at all costs and be\nthe last one standing!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move") DESC_END], 4, rMinigame4vs_Tower, "I Wanna Be The Guy"),
		new Minigame(HAUNTED_FOREST, [DESC_START draw_page("Rules", "Don't let that intimidating ghost see you moving, stop if it faces you!\nIf it's about to turn around it'll laugh and an exclamation mark will appear in its head.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move") DESC_END], 8, rMinigame4vs_Haunted, "I Wanna Kill The Guy"),
		new Minigame(MAGIC_MEMORY, [DESC_START draw_page("Rules", "A set of items are above the pedestals.\nRemember the order of each item before\nthe earthquake strikes!\nPut them all back in the correct order.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Hold/Release Item\n" + draw_action(global.actions.shoot) + " Cover Items") DESC_END], 9, rMinigame4vs_Magic, "Not Another Magic Tower Game"),
		new Minigame(MANSION_ESCAPE, [DESC_START draw_page("Rules", "You've been trapped in the attic of an old\nmansion!\nBe the first to escape!\nFind all the doors that lead downstairs.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.up) + " Open Door") DESC_END], 10, rMinigame4vs_Mansion, "Kid World"),
		new Minigame(PAINTING_PLATFORMS, [DESC_START draw_page("Rules", "It's time to paint! Jump while inside the platforms to paint them with your color, the one with more platforms wins.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 16, rMinigame4vs_Painting, "I Wanna Thank You Mauricio Juega IWBT"),
		new Minigame(BUGS_AROUND, [DESC_START draw_page("Rules", "There's so many bugs! 0/10\nYou need to count the number of bugs of the color that appears at the top. The one closest to the total wins.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Change Number") DESC_END], 17, rMinigame4vs_Bugs, "I Wanna Delete The Huge Bug"),
		new Minigame(UNSTABLE_BLOCKS, [DESC_START draw_page("Rules", "These blocks break upon anything that touches it. Be careful where you stand to be the last one alive!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 18, rMinigame4vs_Blocks, "I Wanna Thank You TheNewGeezer"),
		new Minigame(CRAZY_CHESTS, [DESC_START draw_page("Rules", "Each chest will contain a different amount of coins, and after they're gonna shuffle like crazy, follow the one with the most coins and be the first to pick it! 3 rounds, the chests get crazier everytime.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.up) + " Pick Chest") DESC_END], 19, rMinigame4vs_Chests, "I Wanna Be The Fangame"),
		new Minigame(SLIME_ANNOYER, [DESC_START draw_page("Rules", "Look at that cute slime!\nI bet you wanna annoy it, don't you? Well you can by shooting it, but beware! It can either forgive you or kill you. So try to be the last one standing.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 23, rMinigame4vs_Slime, "SlimePark"),
		new Minigame(ROCKET_IGNITION, [DESC_START draw_page("Rules", "This is a rocket competition, all of you will compete against each other, aiming and shooting everywhere. You have 3 HP each, the last one standing wins!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Turn\n" + draw_action(global.actions.up) + " Accelerate Forward\n" + draw_action(global.actions.down) + " Accelerate Backwards\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 24, rMinigame4vs_Rocket, "I Wanna Walk Out In The Morning Dew"),
		new Minigame(DIZZY_CONUNDRUM, [DESC_START draw_page("Rules", "Try not to get too dizzy on this one!\nCollect all the coins of your respective color. Each time you touch a warp it's gonna shuffle all your actions, so figure out which is which!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Flip Gravity\n" + draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + draw_action(global.actions.jump) + " After Shuffle") DESC_END], 25, rMinigame4vs_Dizzy, "VoVoVo"),
		new Minigame(TARGETING_TARGETS, [DESC_START draw_page("Rules", "Break the targets! You have 6 bullets to do so, red gives you 1 point, blue 2 points and yellow 3 points.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 27, rMinigame4vs_Targets, "I Wanna Be The Micromedley"),
		new Minigame(UNCERTAIN_BULLETS, [DESC_START draw_page("Rules", "Time to dodge the bullets! Blue bullets are water and you can jump infinitely while in them, black and white bullets kill you, avoid them! After a while bouncing cherries spawn on the bottom so avoid them too!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 30, rMinigame4vs_Bullets, "I Wanna Be A Big Man"),
		new Minigame(DRAWN_KEYS, [DESC_START draw_page("Rules", "Grab as much key drawings as possible, green gives 1 point, yellow gives 2 points and red gives 3 points. Make use of the blocks below you, if they're green and you jump they're gonna launch you upwards.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 31, rMinigame4vs_Drawn, "I Wanna Be Drawn"),
		new Minigame(BUBBLE_DERBY, [DESC_START draw_page("Rules", "Time for bubble race! It's hard to control, try not going too fast! If you hit a spike you're unable to move for a bit. Take into account the better you're doing in the race the longer you have to wait. 3 laps to win!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Move") DESC_END], 36, rMinigame4vs_Bubble, "I Wanna Enjoy The Excursion"),
		new Minigame(SKY_DIVING, [DESC_START draw_page("Rules", "I hope you prepared your parachute, because you're falling. And while at it, make sure to touch the yellow saves, red circle gives you 1 point and green circle gives you 2 points. The one with more points wins!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Move") DESC_END], 38, rMinigame4vs_Sky, "I Wanna Kill The Kamilia"),
		new Minigame(GOLF_COURSE, [DESC_START draw_page("Rules", "Mini-golf time! Prepare your shot carefully, the ball needs to land on the flag hole for a perfect 100 score. If it doesn't land you get points based on how close you were and if you fall off no points for you!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Adjust Angle\n" + draw_action(global.actions.jump) + " Use Angle/Use Force\n" + draw_action(global.actions.shoot) + " Cancel Angle") DESC_END], 39, rMinigame4vs_Golf, "I Wanna Run The Marathon"),
		new Minigame(WAKA_EVASION, [DESC_START draw_page("Rules", "The Pac-Man invasion is upon us... pay attention to all the safe trajectories, or else you'll get killed! The last one standing wins!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Change Location") DESC_END], 40, rMinigame4vs_Waka, "I Wanna Be The Onelife"),
		new Minigame(JINGLE_SLEDGE, [DESC_START draw_page("Rules", "Sledge in the snow couldn't be left out! But there's obstacles in the way! Jump to avoid the spikes and shoot to destroy the trees and candies and toggle the colored blocks. First to reach the goal wins!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.jump) + " Jump\n" + draw_action(global.actions.shoot) + " Shoot/Toggle") DESC_END], 35, rMinigame4vs_Jingle, "Jingle Jam")
	];

	m[$ "1vs3"] = [
		new Minigame(AVOID_THE_ANGUISH, [DESC_START draw_page("Rules Solo Player", "Your job is to eliminate the {COLOR,0000FF}Team Players{COLOR,FFFFFF}, choose a different type of attack by hitting the 3 blocks from below. Each attack is different!") DESC_END, DESC_START draw_page("Rules Team Players", "Avoid the cherries at all costs! The {COLOR,0000FF}Solo Player{COLOR,FFFFFF} is trying to eliminate you with his arsenal of cherries! Pay attention to which block they activate.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 5, rMinigame1vs3_Avoid, "I Wanna Be The Lucky"),
		new Minigame(CONVEYOR_HAVOC, [DESC_START draw_page("Rules Solo Player", "That conveyor seems useful, touch the buttons to change the direction the conveyor goes. Confuse the {COLOR,0000FF}Team Players{COLOR,FFFFFF} by changing the conveyor constantly and eliminate them!") DESC_END, DESC_START draw_page("Rules Team Players", "That conveyor is fast, beware! The {COLOR,0000FF}Solo Player{COLOR,FFFFFF} is gonna constantly change the conveyor's direction, pay attention and survive!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 7, rMinigame1vs3_Conveyor, "Not Another Needle Game"),
		new Minigame(NUMBER_SHOWDOWN, [DESC_START draw_page("Rules Solo Player", "Pick a number between 1 and 3.\nIf you happen to choose the same number as\none of your opponents, their block\nfalls apart.") DESC_END, DESC_START draw_page("Rules Team Players", "Pick a number between 1 and 3.\nThat number will be on your block.\nIf that number is the same as the one that\n{COLOR,0000FF}Solo Player{COLOR,FFFFFF} picked, then your\nblock breaks.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.jump) + " Select Number\n" + draw_action(global.actions.left) + draw_action(global.actions.right) + " Change Number") DESC_END], 11, rMinigame1vs3_Showdown, "I Wanna Be The Showdown"),
		new Minigame(GETTINGS_COINS, [DESC_START draw_page("Rules", "So many coins! Perfect for becoming rich! Grab as many coins as you can to win!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 13, rMinigame1vs3_Coins, "I Wanna Get The Coins"),
		new Minigame(GIGANTIC_RACE, [DESC_START draw_page("Rules Solo Player", "A sequence of four buttons will show up below you. Press all of them in the correct order to advance!") DESC_END, DESC_START draw_page("Rules Team Players", "Press the button that shows up above your head on your turn. Once all of you have pressed the three buttons the spaceship will advance!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + draw_action(global.actions.jump) + draw_action(global.actions.shoot) + " Buttons") DESC_END], 15, rMinigame1vs3_Race, "I Wanna Kill The Kamilia 2"),
		new Minigame(WARPING_UP, [DESC_START draw_page("Rules Solo Player", "Avoid the warps at all costs! Your goal is to push three gray blocks all the way to the left in order to cross and kill yourself with the spike. The {COLOR,0000FF}Team Players{COLOR,FFFFFF} will shoot warps up to mess with you.") DESC_END, DESC_START draw_page("Rules Team Players", "The {COLOR,0000FF}Solo Player{COLOR,FFFFFF} is trying to kill themselves, you need to stop them! Shoot warps up constantly to make them go back to the beginning and prevent them from pushing all three gray blocks!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n{COLOR,0000FF}Team Players{COLOR,FFFFFF}:\n" + draw_action(global.actions.shoot) + " Shoot Warp") DESC_END], 22, rMinigame1vs3_Warping, "I Wanna GameOver"),
		new Minigame(HUNT_TROUBLE, [DESC_START draw_page("Rules Solo Player", "The {COLOR,0000FF}Team Players{COLOR,FFFFFF} are hunting you, throw them off by constantly jumping around and try not to fall off the blocks!") DESC_END, DESC_START draw_page("Rules Team Players", "The {COLOR,0000FF}Solo Player{COLOR,FFFFFF} is trying to get away, corner them, aim and then shoot to kill!") DESC_END, DESC_START draw_page("Controls Solo Player", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END, DESC_START draw_page("Controls Team Players", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 26, rMinigame1vs3_Hunt, "I Wanna Be The Ultimatum"),
		new Minigame(AIMING_TILES, [DESC_START draw_page("Rules Solo Player", "Destroy all the {COLOR,0000FF}Team Players{COLOR,FFFFFF}' blocks by shooting at them. But don't destroy the empty blocks or else they're gonna have more freedom to move!") DESC_END, DESC_START draw_page("Rules Team Players", "Don't get hit by the {COLOR,0000FF}Solo Player{COLOR,FFFFFF}' laser! Move around to dodge it, but don't get trapped in between two empty blocks or you're gonna be unable to escape!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n{COLOR,0000FF}Solo Player{COLOR,FFFFFF}:\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 32, rMinigame1vs3_Aiming, "I Wanna Be The Farewell"),
		new Minigame(HIDDEN_HOST, [DESC_START draw_page("Rules Solo Player", "Choose which door you wanna hide in at the start. But try to trick the {COLOR,0000FF}Team Players{COLOR,FFFFFF} by just wandering around. After each round the door the others chose are gonna be locked. It's three rounds to win!") DESC_END, DESC_START draw_page("Rules Team Players", "The {COLOR,0000FF}Solo Player{COLOR,FFFFFF} will choose one of the doors. Try to guess which door they chose, if you fail to find them the door you chose is gonna lock up! Try to find them before three rounds pass.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump Infinitely\n" + draw_action(global.actions.up) + " Pick Door") DESC_END], 33, rMinigame1vs3_Host, "I Wanna Escape Heavenly Host"),
		new Minigame(BAD_HOUSE, [DESC_START draw_page("Rules Solo Player", "That's a very bad house! Don't let the cherries touch you, the house is being controlled by the {COLOR,0000FF}Team Players{COLOR,FFFFFF}, survive and wait for the timer to expire.") DESC_END, DESC_START draw_page("Team Players", "You control the bad house, but each member of the team only has control of a single action. Cooperate and kill the {COLOR,0000FF}Solo Player{COLOR,FFFFFF} before the time runs out!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 34, rMinigame1vs3_House, "Crimson Needle 3")
	];

	m[$ "2vs2"] = [
		new Minigame(A_MAZE_ING, [DESC_START draw_page("Rules", "Quick! You have to assemble your team spike. It's divided into two pieces, you and your teammate must each find one of the pieces and then reunite! Make sure to grab a piece of your team's color!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump Infinitely") DESC_END], 1, rMinigame2vs2_Maze, "I Wanna Kill The Kamilia 3"),
		new Minigame(CATCH_THE_FRUITS, [DESC_START draw_page("Rules", "Fruits are falling from the tree, catch as many as you can to win! Big fruits give 1 point, medium fruits give 2 points and small fruits give 3 points. Don't catch the spiky Gordos or 1 point will be taken away.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move") DESC_END], 6, rMinigame2vs2_Fruits, "I Wanna Be The Aura"),
		new Minigame(BUTTONS_EVERYWHERE, [DESC_START draw_page("Rules", "Compete to press more buttons than the other team! Once the button highlights red you have to be quick and shoot it.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump Infinitely\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 3, rMinigame2vs2_Buttons, "I Wanna Destroy The 6 Players"),
		new Minigame(FITTING_SQUARES, [DESC_START draw_page("Rules", "Each team must assemble\ntheir squares,\nput both of them in the correct orientation\nto fit them!\nPlayers control half square each.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Change Square Angle") DESC_END], 12, rMinigame2vs2_Squares, "I Wanna Reach The Moon"),
		new Minigame(COLORFUL_INSANITY, [DESC_START draw_page("Rules", "That's a ton of colors... cooperate with your teammate to find the only two squares that are exactly the same. 4 rounds to win!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Select/Deselect Square") DESC_END], 14, rMinigame2vs2_Colorful, "I Wanna Be A Charr"),
		new Minigame(SPRINGING_PIRANHA, [DESC_START draw_page("Rules", "Avoid the fireballs! Survive longer than the other team. The upper player bounces around a spring, the bottom player controls the spring. If either on the team die the fireballs start shooting faster!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 20, rMinigame2vs2_Springing, "I Wanna Be The Co-op"),
		new Minigame(DINNYAMIC_DUOS, [DESC_START draw_page("Rules", "Be the first duo to reach the end. Help your teammate to overcome each section. First you need to press buttons by shooting. Then finding the correct warp to advance. And finally inflate the leek to win!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump\n" + draw_action(global.actions.shoot) + " Shoot") DESC_END], 21, rMinigame2vs2_Duos, "I Wannyaaaaaaa"),
		new Minigame(WESTERN_DUEL, [DESC_START draw_page("Rules", "Pay attention! Be the fastest shooter on the old west. Once you see the exclamation mark, shoot as fast as you can. Whoever shoots faster wins 1 point. Reach 5 points to win.") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.shoot) + " Shoot") DESC_END], 28, rMinigame2vs2_Duel, "I Wanna Be The Galaxy"),
		new Minigame(SOCCER_MATCH, [DESC_START draw_page("Rules", "This is soccer, everyone knows the rules! Score 5 points in order to win. If you touch the ball it shoots off based on the direction you're looking, so careful with that!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Jump") DESC_END], 29, rMinigame2vs2_Soccer, "I Wanna Be The GReeeeN"),
		new Minigame(WHAC_AN_IDOL, [DESC_START draw_page("Rules", "Whac-a-mole idol edition! Hit as many idols, gently of course, as you can. The team that hits more idols wins!") DESC_END, DESC_START draw_page("Controls", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) +  draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.shoot) + " Hit") DESC_END], 37, rMinigame2vs2_Idol, "I Wanna Be The iDOLM@STER")
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
			show_popup("FINISH");
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
	show_popup("TIMES UP");
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
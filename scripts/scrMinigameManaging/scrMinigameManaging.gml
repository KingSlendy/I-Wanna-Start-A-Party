function Minigame(title = "Generic Minigame", instructions = "Generic Instructions", preview = sprBox, scene = rTemplate) constructor {
	self.title = title;
	self.instructions = instructions;
	self.preview = preview;
	self.scene = scene;
}

global.minigames = {};
var m = global.minigames;
m[$ "4vs"] = [
	new Minigame()
];

m[$ "1vs3"] = [
	new Minigame()
];

m[$ "2vs2"] = [
	new Minigame(,,, rMinigame2vs2_Maze)
];
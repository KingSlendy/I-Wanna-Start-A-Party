function Item(id, name, desc, sprite, price) constructor {
	self.id = id;
	self.name = name;
	self.desc = desc;
	self.sprite = sprite;
	self.price = price;
}

global.board_items = [
	new Item(0, "Dice", "Lets you roll two dice.", sprItemDice, 10),
	new Item(1, "Double Dice", "Lets you roll three dice.", sprItemDoubleDice, 20),
	new Item(2, "Clock", "Makes your dice roll slow.", sprItemClock, 20),
	new Item(3, "Poison", "Dice gets only a roll from 1-3.\nCan be used on other players.", sprItemPoison, 5),
	new Item(4, "Ice", "Freezes the player you choose.", sprItemIce, 15),
	new Item(5, "Item Steal", "Steals a random item from the player you choose.", sprItemItemSteal, 15),
	new Item(6, "Warp", "Changes location with the player you choose.", sprItemWarp, 25),
	new Item(7, "Cellphone", "You can get an item from the shop delivered.", sprItemCellphone, 12),
	new Item(8, "Blackhole", "Summons a blackhole that can steal coins or shines from other players.", sprItemBlackhole, 30),
	new Item(9, "Mirror", "Teleports you right next to the shine.", sprItemMirror, 30),
	new Item(10, "Medal", "???.", sprItemMedal, 999),
	new Item(11, "Item Bag", "Fills your item slots with random items.", sprItemItemBag, 30),
];
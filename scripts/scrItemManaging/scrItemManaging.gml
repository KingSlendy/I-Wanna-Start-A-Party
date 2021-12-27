function Item(id, name, desc, sprite, price, animation = null, show_criteria) constructor {
	self.id = id;
	self.name = name;
	self.desc = desc;
	self.sprite = sprite;
	self.price = price;
	self.animation = animation;
	self.show_criteria = show_criteria;
}

enum ItemType {
	Dice,
	DoubleDice,
	Clock,
	Poison,
	Ice,
	ItemSteal,
	Warp,
	Cellphone,
	Blackhole,
	Mirror,
	Medal,
	ItemBag
}

global.board_items = [
	new Item(ItemType.Dice, "Dice", "Lets you roll two dice.", sprItemDice, 10),
	new Item(ItemType.DoubleDice, "Double Dice", "Lets you roll three dice.", sprItemDoubleDice, 20),
	new Item(ItemType.Clock, "Clock", "Makes your dice roll slow.", sprItemClock, 20),
	new Item(ItemType.Poison, "Poison", "Dice gets only a roll from 1-3.\nCan be used on other players.", sprItemPoison, 5),
	new Item(ItemType.Ice, "Ice", "Freezes the player you choose.", sprItemIce, 15),
	new Item(ItemType.ItemSteal, "Item Steal", "Steals a random item from the player you choose.", sprItemItemSteal, 15),
	new Item(ItemType.Warp, "Warp", "Changes location with the player you choose.", sprItemWarp, 25, objItemWarpAnimation),
	new Item(ItemType.Cellphone, "Cellphone", "You can get an item from the shop delivered.", sprItemCellphone, 12),
	new Item(ItemType.Blackhole, "Blackhole", "Summons a blackhole that can steal coins or shines from other players.", sprItemBlackhole, 30),
	new Item(ItemType.Mirror, "Mirror", "Teleports you right next to the shine.", sprItemMirror, 30, objItemMirrorAnimation),
	new Item(ItemType.Medal, "Medal", "???.", sprItemMedal, 999),
	new Item(ItemType.ItemBag, "Item Bag", "Fills your item slots with random items.", sprItemItemBag, 30),
];
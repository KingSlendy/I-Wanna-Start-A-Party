function Item(name, desc, sprite, price) constructor {
	self.name = name;
	self.desc = desc;
	self.sprite = sprite;
	self.price = price;
}

global.shop_items = [
	new Item("Dice", "Lets you roll two dice.", sprItemDice, 10),
	new Item("Double Dice", "Lets you roll three dice.", sprItemDoubleDice, 20),
	new Item("Clock", "Makes your dice roll slow.", sprItemClock, 20),
	new Item("Poison", "Dice gets only a roll from 1-3.\nCan be used on other players.", sprItemPoison, 5),
	new Item("Ice", "Freezes the player you choose.", sprItemIce, 15),
	new Item("Item Steal", "Steals a random item from the player you choose.", sprItemItemSteal, 15),
	new Item("Warp", "Changes location with the player you choose.", sprItemWarp, 25),
	new Item("Cellphone", "You can get an item from the shop delivered.", sprItemCellphone, 12),
	new Item("Blackhole", "Summons a blackhole that can steal coins or shines from other players.", sprItemBlackhole, 30),
	new Item("Mirror", "Teleports you right next to the shine.", sprItemMirror, 30),
	new Item("Medal", "???.", sprItemMedal, 999),
	new Item("Item Bag", "Fills your item slots with random items.", sprItemItemBag, 30),
];
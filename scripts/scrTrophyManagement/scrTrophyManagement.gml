global.trophy_hint_price = 100;
global.trophy_spoiler_price = 1000;

function Trophy(image, rank, name, description, short) constructor {
	self.image = image;
	self.rank = rank;
	self.name = name;
	self.description = description;
	self.short = short;
	self.location = -1;
	
	static achieve = function() {
		if (!instance_exists(objCollectedTrophy)) {
			var t = instance_create_layer(0, 0, "Managers", objCollectedTrophy);
			t.rank = self.rank;
			t.image = self.image;
			t.trophy = self.image - 1;
		} else {
			array_push(global.collected_trophies_stack, self.image - 1);
		}
	
		array_push(global.collected_trophies, self.image - 1);
		array_sort(global.collected_trophies, true);
		self.hint();
		self.spoiler();
		var amount = 0;
		
		switch (self.rank) {
			case TrophyRank.Bronze: amount = 100; break;
			case TrophyRank.Silver: amount = 200; break;
			case TrophyRank.Gold: amount = 1000; break;
			case TrophyRank.Platinum: amount = 2000; break;
		}
		
		change_collected_coins(amount);
		save_file();
	}
	
	static hint = function() {
		array_push(global.collected_hint_trophies, self.image - 1);
		array_sort(global.collected_hint_trophies, true);
		save_file();
	}
	
	static spoiler = function() {
		array_push(global.collected_spoiler_trophies, self.image - 1);
		array_sort(global.collected_spoiler_trophies, true);
		save_file();
	}
	
	static state = function() {
		if (achieved_trophy(self.image - 1) || spoilered_trophy(self.image - 1)) {
			return TrophyState.Known;
		}
		
		if (hinted_trophy(self.image - 1)) {
			return TrophyState.Hint;
		}
		
		return TrophyState.Unknown;
	}
}

enum TrophyRank {
	Platinum,
	Gold,
	Silver,
	Bronze,
	Unknown
}

enum TrophyState {
	Known,
	Hint,
	Unknown
}

function trophies_init() {
	global.trophies = [
		///Boards
		new Trophy(1, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_1"), language_get_text("TROPHIES_DESCRIPTION_1"), language_get_text("TROPHIES_HINT_1")),
		new Trophy(2, TrophyRank.Silver, language_get_text("TROPHIES_NAME_2"), language_get_text("TROPHIES_DESCRIPTION_2"), language_get_text("TROPHIES_HINT_2")),
		new Trophy(3, TrophyRank.Gold, language_get_text("TROPHIES_NAME_3"), language_get_text("TROPHIES_DESCRIPTION_3"), language_get_text("TROPHIES_HINT_3")),
		new Trophy(6, TrophyRank.Silver, language_get_text("TROPHIES_NAME_4"), language_get_text("TROPHIES_DESCRIPTION_4"), language_get_text("TROPHIES_HINT_4")),
		new Trophy(7, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_5"), language_get_text("TROPHIES_DESCRIPTION_5"), language_get_text("TROPHIES_HINT_5")),
		new Trophy(56, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_6"), language_get_text("TROPHIES_DESCRIPTION_6"), language_get_text("TROPHIES_HINT_6")),
		new Trophy(12, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_7"), language_get_text("TROPHIES_DESCRIPTION_7"), language_get_text("TROPHIES_HINT_7")),
		new Trophy(4, TrophyRank.Silver, language_get_text("TROPHIES_NAME_8"), language_get_text("TROPHIES_DESCRIPTION_8"), language_get_text("TROPHIES_HINT_8")),
		new Trophy(5, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_9"), language_get_text("TROPHIES_DESCRIPTION_9"), language_get_text("TROPHIES_HINT_9")),
		new Trophy(24, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_10"), language_get_text("TROPHIES_DESCRIPTION_10"), language_get_text("TROPHIES_HINT_10")),
		new Trophy(61, TrophyRank.Gold, language_get_text("TROPHIES_NAME_11"), language_get_text("TROPHIES_DESCRIPTION_11"), language_get_text("TROPHIES_HINT_11")),
		new Trophy(31, TrophyRank.Silver, language_get_text("TROPHIES_NAME_12"), language_get_text("TROPHIES_DESCRIPTION_12"), language_get_text("TROPHIES_HINT_12")),
		new Trophy(55, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_13"), language_get_text("TROPHIES_DESCRIPTION_13"), language_get_text("TROPHIES_HINT_13")),
		new Trophy(25, TrophyRank.Silver, language_get_text("TROPHIES_NAME_14"), language_get_text("TROPHIES_DESCRIPTION_14"), language_get_text("TROPHIES_HINT_14")),
		new Trophy(71, TrophyRank.Gold, language_get_text("TROPHIES_NAME_15"), language_get_text("TROPHIES_DESCRIPTION_15"), language_get_text("TROPHIES_HINT_15")),
		new Trophy(72, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_16"), language_get_text("TROPHIES_DESCRIPTION_16"), language_get_text("TROPHIES_HINT_16")),
		new Trophy(62, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_17"), language_get_text("TROPHIES_DESCRIPTION_17"), language_get_text("TROPHIES_HINT_17")),
		new Trophy(57, TrophyRank.Silver, language_get_text("TROPHIES_NAME_18"), language_get_text("TROPHIES_DESCRIPTION_18"), language_get_text("TROPHIES_HINT_18")),
		new Trophy(46, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_19"), language_get_text("TROPHIES_DESCRIPTION_19"), language_get_text("TROPHIES_HINT_19")),
		new Trophy(47, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_20"), language_get_text("TROPHIES_DESCRIPTION_20"), language_get_text("TROPHIES_HINT_20")),
		new Trophy(20, TrophyRank.Gold, language_get_text("TROPHIES_NAME_21"), language_get_text("TROPHIES_DESCRIPTION_21"), language_get_text("TROPHIES_HINT_21")),
		new Trophy(21, TrophyRank.Gold, language_get_text("TROPHIES_NAME_22"), language_get_text("TROPHIES_DESCRIPTION_22"), language_get_text("TROPHIES_HINT_22")),
		new Trophy(22, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_23"), language_get_text("TROPHIES_DESCRIPTION_23"), language_get_text("TROPHIES_HINT_23")),
		new Trophy(37, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_24"), language_get_text("TROPHIES_DESCRIPTION_24"), language_get_text("TROPHIES_HINT_24")),
		new Trophy(42, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_25"), language_get_text("TROPHIES_DESCRIPTION_25"), language_get_text("TROPHIES_HINT_25")),
		new Trophy(84, TrophyRank.Silver, language_get_text("TROPHIES_NAME_84"), language_get_text("TROPHIES_DESCRIPTION_84"), language_get_text("TROPHIES_HINT_84")),
	
		//Island
		new Trophy(35, TrophyRank.Silver, language_get_text("TROPHIES_NAME_26"), language_get_text("TROPHIES_DESCRIPTION_26"), language_get_text("TROPHIES_HINT_26")),
		new Trophy(36, TrophyRank.Silver, language_get_text("TROPHIES_NAME_27"), language_get_text("TROPHIES_DESCRIPTION_27"), language_get_text("TROPHIES_HINT_27")),
		new Trophy(43, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_28"), language_get_text("TROPHIES_DESCRIPTION_28"), language_get_text("TROPHIES_HINT_28")),
	
		//Baba
		new Trophy(97, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_97"), language_get_text("TROPHIES_DESCRIPTION_97"), language_get_text("TROPHIES_HINT_97")),
	
		//Pallet
		new Trophy(73, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_29"), language_get_text("TROPHIES_DESCRIPTION_29"), language_get_text("TROPHIES_HINT_29")),
		new Trophy(74, TrophyRank.Silver, language_get_text("TROPHIES_NAME_30"), language_get_text("TROPHIES_DESCRIPTION_30"), language_get_text("TROPHIES_HINT_30")),
		new Trophy(75, TrophyRank.Gold, language_get_text("TROPHIES_NAME_31"), language_get_text("TROPHIES_DESCRIPTION_31"), language_get_text("TROPHIES_HINT_31")),
	
		//Hyrule
		new Trophy(51, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_32"), language_get_text("TROPHIES_DESCRIPTION_32"), language_get_text("TROPHIES_HINT_32")),
	
		//FASF
		new Trophy(83, TrophyRank.Gold, language_get_text("TROPHIES_NAME_83"), language_get_text("TROPHIES_DESCRIPTION_83"), language_get_text("TROPHIES_HINT_83")),
	
		///Minigames
		new Trophy(10, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_33"), language_get_text("TROPHIES_DESCRIPTION_33"), language_get_text("TROPHIES_HINT_33")),
	
		//4vs
		new Trophy(18, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_34"), language_get_text("TROPHIES_DESCRIPTION_34"), language_get_text("TROPHIES_HINT_34")),
		new Trophy(11, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_35"), language_get_text("TROPHIES_DESCRIPTION_35"), language_get_text("TROPHIES_HINT_35")),
		new Trophy(8, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_36"), language_get_text("TROPHIES_DESCRIPTION_36"), language_get_text("TROPHIES_HINT_36")),
		new Trophy(9, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_37"), language_get_text("TROPHIES_DESCRIPTION_37"), language_get_text("TROPHIES_HINT_37")),
		new Trophy(15, TrophyRank.Gold, language_get_text("TROPHIES_NAME_38"), language_get_text("TROPHIES_DESCRIPTION_38"), language_get_text("TROPHIES_HINT_38")),
		new Trophy(93, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_93"), language_get_text("TROPHIES_DESCRIPTION_93"), language_get_text("TROPHIES_HINT_93")),
		new Trophy(29, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_39"), language_get_text("TROPHIES_DESCRIPTION_39"), language_get_text("TROPHIES_HINT_39")),
		new Trophy(64, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_40"), language_get_text("TROPHIES_DESCRIPTION_40"), language_get_text("TROPHIES_HINT_40")),
		new Trophy(39, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_41"), language_get_text("TROPHIES_DESCRIPTION_41"), language_get_text("TROPHIES_HINT_41")),
		new Trophy(45, TrophyRank.Silver, language_get_text("TROPHIES_NAME_42"), language_get_text("TROPHIES_DESCRIPTION_42"), language_get_text("TROPHIES_HINT_42")),
		new Trophy(44, TrophyRank.Gold, language_get_text("TROPHIES_NAME_43"), language_get_text("TROPHIES_DESCRIPTION_43"), language_get_text("TROPHIES_HINT_43")),
		new Trophy(52, TrophyRank.Gold, language_get_text("TROPHIES_NAME_44"), language_get_text("TROPHIES_DESCRIPTION_44"), language_get_text("TROPHIES_HINT_44")),
		new Trophy(48, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_45"), language_get_text("TROPHIES_DESCRIPTION_45"), language_get_text("TROPHIES_HINT_45")),
		new Trophy(60, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_46"), language_get_text("TROPHIES_DESCRIPTION_46"), language_get_text("TROPHIES_HINT_46")),
		new Trophy(96, TrophyRank.Gold, language_get_text("TROPHIES_NAME_96"), language_get_text("TROPHIES_DESCRIPTION_96"), language_get_text("TROPHIES_HINT_96")),
		new Trophy(59, TrophyRank.Silver, language_get_text("TROPHIES_NAME_47"), language_get_text("TROPHIES_DESCRIPTION_47"), language_get_text("TROPHIES_HINT_47")),
		new Trophy(68, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_48"), language_get_text("TROPHIES_DESCRIPTION_48"), language_get_text("TROPHIES_HINT_48")),
		new Trophy(76, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_49"), language_get_text("TROPHIES_DESCRIPTION_49"), language_get_text("TROPHIES_HINT_49")),
		new Trophy(63, TrophyRank.Silver, language_get_text("TROPHIES_NAME_50"), language_get_text("TROPHIES_DESCRIPTION_50"), language_get_text("TROPHIES_HINT_50")),
		new Trophy(67, TrophyRank.Silver, language_get_text("TROPHIES_NAME_51"), language_get_text("TROPHIES_DESCRIPTION_51"), language_get_text("TROPHIES_HINT_51")),
		new Trophy(70, TrophyRank.Silver, language_get_text("TROPHIES_NAME_52"), language_get_text("TROPHIES_DESCRIPTION_52"), language_get_text("TROPHIES_HINT_52")),
		new Trophy(81, TrophyRank.Gold, language_get_text("TROPHIES_NAME_81"), language_get_text("TROPHIES_DESCRIPTION_81"), language_get_text("TROPHIES_HINT_81")),
		new Trophy(82, TrophyRank.Silver, language_get_text("TROPHIES_NAME_82"), language_get_text("TROPHIES_DESCRIPTION_82"), language_get_text("TROPHIES_HINT_82")),
		new Trophy(86, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_86"), language_get_text("TROPHIES_DESCRIPTION_86"), language_get_text("TROPHIES_HINT_86")),
		new Trophy(87, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_87"), language_get_text("TROPHIES_DESCRIPTION_87"), language_get_text("TROPHIES_HINT_87")),
		new Trophy(88, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_88"), language_get_text("TROPHIES_DESCRIPTION_88"), language_get_text("TROPHIES_HINT_88")),
		new Trophy(89, TrophyRank.Silver, language_get_text("TROPHIES_NAME_89"), language_get_text("TROPHIES_DESCRIPTION_89"), language_get_text("TROPHIES_HINT_89")),
		new Trophy(90, TrophyRank.Silver, language_get_text("TROPHIES_NAME_90"), language_get_text("TROPHIES_DESCRIPTION_90"), language_get_text("TROPHIES_HINT_90")),
		new Trophy(92, TrophyRank.Silver, language_get_text("TROPHIES_NAME_92"), language_get_text("TROPHIES_DESCRIPTION_92"), language_get_text("TROPHIES_HINT_92")),
	
		//1vs3
		new Trophy(19, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_53"), language_get_text("TROPHIES_DESCRIPTION_53"), language_get_text("TROPHIES_HINT_53")),
		new Trophy(13, TrophyRank.Gold, language_get_text("TROPHIES_NAME_54"), language_get_text("TROPHIES_DESCRIPTION_54"), language_get_text("TROPHIES_HINT_54")),
		new Trophy(14, TrophyRank.Gold, language_get_text("TROPHIES_NAME_55"), language_get_text("TROPHIES_DESCRIPTION_55"), language_get_text("TROPHIES_HINT_55")),
		new Trophy(16, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_56"), language_get_text("TROPHIES_DESCRIPTION_56"), language_get_text("TROPHIES_HINT_56")),
		new Trophy(17, TrophyRank.Gold, language_get_text("TROPHIES_NAME_57"), language_get_text("TROPHIES_DESCRIPTION_57"), language_get_text("TROPHIES_HINT_57")),
		new Trophy(38, TrophyRank.Silver, language_get_text("TROPHIES_NAME_58"), language_get_text("TROPHIES_DESCRIPTION_58"), language_get_text("TROPHIES_HINT_58")),
		new Trophy(77, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_59"), language_get_text("TROPHIES_DESCRIPTION_59"), language_get_text("TROPHIES_HINT_59")),
		new Trophy(54, TrophyRank.Silver, language_get_text("TROPHIES_NAME_60"), language_get_text("TROPHIES_DESCRIPTION_60"), language_get_text("TROPHIES_HINT_60")),
		new Trophy(53, TrophyRank.Silver, language_get_text("TROPHIES_NAME_61"), language_get_text("TROPHIES_DESCRIPTION_61"), language_get_text("TROPHIES_HINT_61")),
		new Trophy(95, TrophyRank.Gold, language_get_text("TROPHIES_NAME_95"), language_get_text("TROPHIES_DESCRIPTION_95"), language_get_text("TROPHIES_HINT_95")),
		new Trophy(94, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_94"), language_get_text("TROPHIES_DESCRIPTION_94"), language_get_text("TROPHIES_HINT_94")),
	
		//2vs2
		new Trophy(28, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_62"), language_get_text("TROPHIES_DESCRIPTION_62"), language_get_text("TROPHIES_HINT_62")),
		new Trophy(26, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_63"), language_get_text("TROPHIES_DESCRIPTION_63"), language_get_text("TROPHIES_HINT_63")),
		new Trophy(27, TrophyRank.Silver, language_get_text("TROPHIES_NAME_64"), language_get_text("TROPHIES_DESCRIPTION_64"), language_get_text("TROPHIES_HINT_64")),
		new Trophy(30, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_65"), language_get_text("TROPHIES_DESCRIPTION_65"), language_get_text("TROPHIES_HINT_65")),
		new Trophy(23, TrophyRank.Silver, language_get_text("TROPHIES_NAME_66"), language_get_text("TROPHIES_DESCRIPTION_66"), language_get_text("TROPHIES_HINT_66")),
		new Trophy(69, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_67"), language_get_text("TROPHIES_DESCRIPTION_67"), language_get_text("TROPHIES_HINT_67")),
		new Trophy(49, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_68"), language_get_text("TROPHIES_DESCRIPTION_68"), language_get_text("TROPHIES_HINT_68")),
		new Trophy(66, TrophyRank.Silver, language_get_text("TROPHIES_NAME_69"), language_get_text("TROPHIES_DESCRIPTION_69"), language_get_text("TROPHIES_HINT_69")),
		new Trophy(50, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_70"), language_get_text("TROPHIES_DESCRIPTION_70"), language_get_text("TROPHIES_HINT_70")),
		new Trophy(85, TrophyRank.Gold, language_get_text("TROPHIES_NAME_85"), language_get_text("TROPHIES_DESCRIPTION_85"), language_get_text("TROPHIES_HINT_85")),
		new Trophy(91, TrophyRank.Gold, language_get_text("TROPHIES_NAME_91"), language_get_text("TROPHIES_DESCRIPTION_91"), language_get_text("TROPHIES_HINT_91")),
	
		//Results
		new Trophy(32, TrophyRank.Silver, language_get_text("TROPHIES_NAME_71"), language_get_text("TROPHIES_DESCRIPTION_71"), language_get_text("TROPHIES_HINT_71")),
		new Trophy(33, TrophyRank.Silver, language_get_text("TROPHIES_NAME_72"), language_get_text("TROPHIES_DESCRIPTION_72"), language_get_text("TROPHIES_HINT_72")),
		new Trophy(40, TrophyRank.Gold, language_get_text("TROPHIES_NAME_73"), language_get_text("TROPHIES_DESCRIPTION_73"), language_get_text("TROPHIES_HINT_73")),
		new Trophy(41, TrophyRank.Bronze, language_get_text("TROPHIES_NAME_74"), language_get_text("TROPHIES_DESCRIPTION_74"), language_get_text("TROPHIES_HINT_74")),
		new Trophy(34, TrophyRank.Silver, language_get_text("TROPHIES_NAME_75"), language_get_text("TROPHIES_DESCRIPTION_75"), language_get_text("TROPHIES_HINT_75")),
		new Trophy(58, TrophyRank.Gold, language_get_text("TROPHIES_NAME_76"), language_get_text("TROPHIES_DESCRIPTION_76"), language_get_text("TROPHIES_HINT_76")),

		//All
		new Trophy(65, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_77"), language_get_text("TROPHIES_DESCRIPTION_77"), language_get_text("TROPHIES_HINT_77")),
		new Trophy(78, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_78"), language_get_text("TROPHIES_DESCRIPTION_78"), language_get_text("TROPHIES_HINT_78")),
		new Trophy(79, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_79"), language_get_text("TROPHIES_DESCRIPTION_79"), language_get_text("TROPHIES_HINT_79")),
		new Trophy(80, TrophyRank.Platinum, language_get_text("TROPHIES_NAME_80"), language_get_text("TROPHIES_DESCRIPTION_80"), language_get_text("TROPHIES_HINT_80"))
	];

	for (var i = 0; i < array_length(global.trophies); i++) {
		global.trophies[i].location = i;
	}
}

global.collected_trophies_stack = [];

function get_trophy(image) {
	for (var i = 0; i < array_length(global.trophies); i++) {
		var trophy = global.trophies[i];
		
		if (trophy.image == image + 1) {
			return trophy;
		}
	}
	
	return null;
}

function achieve_trophy(image) {
	if (achieved_trophy(image)) {
		return;
	}
	
	var trophy = get_trophy(image);
	trophy.achieve();
	
	if (array_length(global.collected_trophies) == array_length(global.trophies) - 1) {
		achieve_trophy(79);
	}
}

function achieved_trophy(image) {
	return (array_search(global.collected_trophies, image));
}

function hint_trophy(image) {
	if (hinted_trophy(image)) {
		return;
	}
	
	var trophy = get_trophy(image);
	trophy.hint();
}

function hinted_trophy(image) {
	return (array_search(global.collected_hint_trophies, image));
}

function spoiler_trophy(image) {
	if (spoilered_trophy(image)) {
		return;
	}
	
	var trophy = get_trophy(image);
	trophy.spoiler();
}

function spoilered_trophy(image) {
	return (array_search(global.collected_spoiler_trophies, image));
}

function collect_trophy(image) {
	var trophy = get_trophy(image);
	var t = instance_create_layer(0, 0, "Managers", objCollectedTrophy);
	t.rank = trophy.rank;
	t.image = trophy.image;
	t.trophy = image;
}

function draw_trophy(x, y, trophy) {
	draw_sprite(sprTrophyCups, (achieved_trophy(trophy.image - 1)) ? trophy.rank : TrophyRank.Unknown, x, y);
	
	var image_y = y;
	
	switch (trophy.rank) {
		case TrophyRank.Platinum: image_y -= 125; break;
		case TrophyRank.Gold: image_y -= 105; break;
		case TrophyRank.Silver: image_y -= 100; break;
		case TrophyRank.Bronze: image_y -= 115; break;
	}
	
	draw_sprite(sprTrophyImages, (achieved_trophy(trophy.image - 1)) ? trophy.image : 0, x, image_y);
	language_set_font(global.fntFilesData);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_text_outline(x, y - 40, string(trophy.location + 1), c_black);
	draw_set_halign(fa_left);
}

function change_collected_coins(amount) {
	if (amount == 0) {
		return;
	}
	
	var c = instance_create_layer(0, 0, "Managers", objCollectedCoins);
	c.amount = amount;
	global.collected_coins += amount;
}
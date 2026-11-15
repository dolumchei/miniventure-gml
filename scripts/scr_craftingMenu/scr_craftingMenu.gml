function CraftingMenu(recipes, player) : Menu() constructor
{
	selected = 0; 

	self.recipes = recipes; 
	self.player = player; 

	for (var i = 0; i < array_length(recipes); i++)
		self.recipes[i].checkCanCraft(player); 

	array_sort(self.recipes,
		function (r1, r2) 
		{
			if (r1.canCraft && !r2.canCraft)
				return -1; 
			if (!r1.canCraft && r2.canCraft)
				return 1; 
			return 0; 
		}
	);

	static tick = function()
	{
		if (input.menu.pressed())
			game.setMenu(undefined); 

		if (input.up.check())
			selected--; 
		if (input.down.check())
			selected++; 

		var len = array_length(recipes); 
		if (len == 0)
			selected = 0; 
		if (selected < 0)
			selected += len; 
		if (selected >= len)
			selected -= len; 

		if (input.attack.pressed() && len > 0)
		{
			var r = recipes[selected]; 
			r.checkCanCraft(player); 
			if (r.canCraft)
			{ 
				r.deductCost(player); 
				r.craft(player); 
				global.Sound.craft.play(); 
			}
			for (var i = 0; i < array_length(recipes); i++) 
				recipes[i].checkCanCraft(player); 
		}
	}

	static render = function(screen)
	{
		global.Font.renderFrame(screen, "Have", 12, 1, 19, 3); 
		global.Font.renderFrame(screen, "Cost", 12, 4, 19, 11); 
		global.Font.renderFrame(screen, "Crafting", 0, 1, 11, 11); 
		renderItemList(screen, 0, 1, 11, 11, recipes, selected); 

		if (array_length(recipes) > 0)
		{ 
			var recipe = recipes[selected]; 
			var hasResultItems = player.inventory.count(recipe.resultTemplate); 
			var xo = 13 * 8; 
			screen.render(xo, 2 * 8, recipe.resultTemplate.getSprite(), recipe.resultTemplate.getColor(), 0); 
			global.Font.draw(string(hasResultItems), screen, xo + 8, 2 * 8, global.Color.get(-1, 555, 555, 555)); 

			var costs = recipe.costs; 
			for (var i = 0; i < array_length(costs); i++)
			{ 
				var item = costs[i]; 
				var yo = (5 + i) * 8; 
				screen.render(xo, yo, item.getSprite(), item.getColor(), 0); 
				var requiredAmt = 1; 
				if (is_instanceof(item, ResourceItem))
					requiredAmt = (item).count; 
				var has = player.inventory.count(item); 
				var color = global.Color.get(-1, 555, 555, 555); 
				if (has < requiredAmt)
					color = global.Color.get(-1, 222, 222, 222); 
				if (has > 99)
					has = 99; 
				global.Font.draw(string(requiredAmt) + "/" + string(has), screen, xo + 8, yo, color); 
			}
		}
		
	}
}
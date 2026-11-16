function DebugMenu(player) : Menu() constructor
{
	selected = 0; 
	selected_2 = 0;

	self.recipes = [ ];
	self.recipeMenus = [ ];
	
	array_push(recipeMenus, [ global.Crafting.debugRecipes, "Item" ]);
	array_push(recipeMenus, [ global.Crafting.workbenchRecipes, "Workbench" ]);
	array_push(recipeMenus, [ global.Crafting.ovenRecipes, "Oven" ]);
	array_push(recipeMenus, [ global.Crafting.furnaceRecipes, "Furnace" ]);
	array_push(recipeMenus, [ global.Crafting.anvilRecipes, "Anvil" ]);
	
	self.recipes = recipeMenus[selected_2][0];
	
	for (var i = 0; i < array_length(recipeMenus); i++)
	{
		for (var j = 0; j < array_length(recipeMenus[i][0]); j++)
			self.recipeMenus[i][0][j].canCraft = true;
	}
	
	self.player = player; 

	tick = function()
	{
		if (input.menu.pressed())
			game.setMenu(undefined); 

		if (input.up.check())
			selected--; 
		if (input.down.check())
			selected++; 

		if (input.left.check())
		{
			selected = 0;
			selected_2--; 
		}
		if (input.right.check())
		{
			selected_2++; 
			selected = 0;
		}
		
		var len = array_length(recipes); 
		if (len == 0)
			selected = 0; 
		if (selected < 0)
			selected += len; 
		if (selected >= len)
			selected -= len; 
			
		var len2 = array_length(recipeMenus); 
		if (len2 == 0)
			selected_2 = 0; 
		if (selected_2 < 0)
			selected_2 += len2; 
		if (selected_2 >= len2)
			selected_2 -= len2; 
			
		self.recipes = recipeMenus[selected_2][0];

		if (input.attack.pressed() && len > 0)
		{
			var r = recipes[selected]; 
			r.craft(player); 
			global.Sound.craft.play(); 
		}
	}

	render = function(screen)
	{
		global.Font.renderFrame(screen, "Have", 12, 1, 19, 3); 
		global.Font.renderFrame(screen, "Cost", 12, 4, 19, 11); 
		global.Font.renderFrame(screen, recipeMenus[selected_2][1], 0, 1, 11, 11); 
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
				if (has > 99)
					has = 99; 
				global.Font.draw(string(requiredAmt) + "/" + string(has), screen, xo + 8, yo, global.Color.get(-1, 555, 555, 555)); 
			}
		}
		
	}
}
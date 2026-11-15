function singleton_Crafting() constructor
{
	anvilRecipes = [ ];
	ovenRecipes = [ ];
	furnaceRecipes = [ ];
	workbenchRecipes = [ ];

	array_push(workbenchRecipes, new FurnitureRecipe(Lantern).addCost(global.Resource.wood, 5).addCost(global.Resource.slime, 10).addCost(global.Resource.glass, 4));
	array_push(workbenchRecipes, new FurnitureRecipe(Oven).addCost(global.Resource.stone, 15));
	array_push(workbenchRecipes, new FurnitureRecipe(Furnace).addCost(global.Resource.stone, 20));
	array_push(workbenchRecipes, new FurnitureRecipe(Workbench).addCost(global.Resource.wood, 20));
	array_push(workbenchRecipes, new FurnitureRecipe(Chest).addCost(global.Resource.wood, 20));
	array_push(workbenchRecipes, new FurnitureRecipe(Anvil).addCost(global.Resource.ironIngot, 5));

	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.sword, 0).addCost(global.Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.axe, 0).addCost(global.Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.hoe, 0).addCost(global.Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.pickaxe, 0).addCost(global.Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.shovel, 0).addCost(global.Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.sword, 1).addCost(global.Resource.wood, 5).addCost(global.Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.axe, 1).addCost(global.Resource.wood, 5).addCost(global.Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.hoe, 1).addCost(global.Resource.wood, 5).addCost(global.Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.pickaxe, 1).addCost(global.Resource.wood, 5).addCost(global.Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(global.ToolType.shovel, 1).addCost(global.Resource.wood, 5).addCost(global.Resource.stone, 5));

	array_push(anvilRecipes, new ToolRecipe(global.ToolType.sword, 2).addCost(global.Resource.wood, 5).addCost(global.Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.axe, 2).addCost(global.Resource.wood, 5).addCost(global.Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.hoe, 2).addCost(global.Resource.wood, 5).addCost(global.Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.pickaxe, 2).addCost(global.Resource.wood, 5).addCost(global.Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.shovel, 2).addCost(global.Resource.wood, 5).addCost(global.Resource.ironIngot, 5));

	array_push(anvilRecipes, new ToolRecipe(global.ToolType.sword, 3).addCost(global.Resource.wood, 5).addCost(global.Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.axe, 3).addCost(global.Resource.wood, 5).addCost(global.Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.hoe, 3).addCost(global.Resource.wood, 5).addCost(global.Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.pickaxe, 3).addCost(global.Resource.wood, 5).addCost(global.Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.shovel, 3).addCost(global.Resource.wood, 5).addCost(global.Resource.goldIngot, 5));

	array_push(anvilRecipes, new ToolRecipe(global.ToolType.sword, 4).addCost(global.Resource.wood, 5).addCost(global.Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.axe, 4).addCost(global.Resource.wood, 5).addCost(global.Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.hoe, 4).addCost(global.Resource.wood, 5).addCost(global.Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.pickaxe, 4).addCost(global.Resource.wood, 5).addCost(global.Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(global.ToolType.shovel, 4).addCost(global.Resource.wood, 5).addCost(global.Resource.gem, 50));

	array_push(furnaceRecipes, new ResourceRecipe(global.Resource.ironIngot).addCost(global.Resource.ironOre, 4).addCost(global.Resource.coal, 1));
	array_push(furnaceRecipes, new ResourceRecipe(global.Resource.goldIngot).addCost(global.Resource.goldOre, 4).addCost(global.Resource.coal, 1));
	array_push(furnaceRecipes, new ResourceRecipe(global.Resource.glass).addCost(global.Resource.sand, 4).addCost(global.Resource.coal, 1));

	array_push(ovenRecipes, new ResourceRecipe(global.Resource.bread).addCost(global.Resource.wheat, 4));
}
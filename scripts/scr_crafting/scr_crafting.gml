function Crafting() constructor
{
	static anvilRecipes = [ ];
	static ovenRecipes = [ ];
	static furnaceRecipes = [ ];
	static workbenchRecipes = [ ];
	
	static debugRecipes = [ ];

	array_push(workbenchRecipes, new FurnitureRecipe(Lantern).addCost(Resource.wood, 5).addCost(Resource.slime, 10).addCost(Resource.glass, 4));
	array_push(workbenchRecipes, new FurnitureRecipe(Oven).addCost(Resource.stone, 15));
	array_push(workbenchRecipes, new FurnitureRecipe(Furnace).addCost(Resource.stone, 20));
	array_push(workbenchRecipes, new FurnitureRecipe(Workbench).addCost(Resource.wood, 20));
	array_push(workbenchRecipes, new FurnitureRecipe(Chest).addCost(Resource.wood, 20));
	array_push(workbenchRecipes, new FurnitureRecipe(Anvil).addCost(Resource.ironIngot, 5));

	array_push(workbenchRecipes, new ToolRecipe(ToolType.sword, 0).addCost(Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.axe, 0).addCost(Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.hoe, 0).addCost(Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.pickaxe, 0).addCost(Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.shovel, 0).addCost(Resource.wood, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.sword, 1).addCost(Resource.wood, 5).addCost(Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.axe, 1).addCost(Resource.wood, 5).addCost(Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.hoe, 1).addCost(Resource.wood, 5).addCost(Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.pickaxe, 1).addCost(Resource.wood, 5).addCost(Resource.stone, 5));
	array_push(workbenchRecipes, new ToolRecipe(ToolType.shovel, 1).addCost(Resource.wood, 5).addCost(Resource.stone, 5));

	array_push(anvilRecipes, new ToolRecipe(ToolType.sword, 2).addCost(Resource.wood, 5).addCost(Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.axe, 2).addCost(Resource.wood, 5).addCost(Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.hoe, 2).addCost(Resource.wood, 5).addCost(Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.pickaxe, 2).addCost(Resource.wood, 5).addCost(Resource.ironIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.shovel, 2).addCost(Resource.wood, 5).addCost(Resource.ironIngot, 5));

	array_push(anvilRecipes, new ToolRecipe(ToolType.sword, 3).addCost(Resource.wood, 5).addCost(Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.axe, 3).addCost(Resource.wood, 5).addCost(Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.hoe, 3).addCost(Resource.wood, 5).addCost(Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.pickaxe, 3).addCost(Resource.wood, 5).addCost(Resource.goldIngot, 5));
	array_push(anvilRecipes, new ToolRecipe(ToolType.shovel, 3).addCost(Resource.wood, 5).addCost(Resource.goldIngot, 5));

	array_push(anvilRecipes, new ToolRecipe(ToolType.sword, 4).addCost(Resource.wood, 5).addCost(Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(ToolType.axe, 4).addCost(Resource.wood, 5).addCost(Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(ToolType.hoe, 4).addCost(Resource.wood, 5).addCost(Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(ToolType.pickaxe, 4).addCost(Resource.wood, 5).addCost(Resource.gem, 50));
	array_push(anvilRecipes, new ToolRecipe(ToolType.shovel, 4).addCost(Resource.wood, 5).addCost(Resource.gem, 50));

	array_push(furnaceRecipes, new ResourceRecipe(Resource.ironIngot).addCost(Resource.ironOre, 4).addCost(Resource.coal, 1));
	array_push(furnaceRecipes, new ResourceRecipe(Resource.goldIngot).addCost(Resource.goldOre, 4).addCost(Resource.coal, 1));
	array_push(furnaceRecipes, new ResourceRecipe(Resource.glass).addCost(Resource.sand, 4).addCost(Resource.coal, 1));

	array_push(ovenRecipes, new ResourceRecipe(Resource.bread).addCost(Resource.wheat, 4));
	
	array_push(debugRecipes, new ResourceRecipe(Resource.wood));
	array_push(debugRecipes, new ResourceRecipe(Resource.stone));
	array_push(debugRecipes, new ResourceRecipe(Resource.flower));
	array_push(debugRecipes, new ResourceRecipe(Resource.acorn));
	array_push(debugRecipes, new ResourceRecipe(Resource.dirt));
	array_push(debugRecipes, new ResourceRecipe(Resource.sand));
	array_push(debugRecipes, new ResourceRecipe(Resource.cactusFlower));
	array_push(debugRecipes, new ResourceRecipe(Resource.seeds));
	array_push(debugRecipes, new ResourceRecipe(Resource.wheat));
	array_push(debugRecipes, new ResourceRecipe(Resource.bread));
	array_push(debugRecipes, new ResourceRecipe(Resource.apple));

	array_push(debugRecipes, new ResourceRecipe(Resource.coal));
	array_push(debugRecipes, new ResourceRecipe(Resource.ironOre));
	array_push(debugRecipes, new ResourceRecipe(Resource.goldOre));
	array_push(debugRecipes, new ResourceRecipe(Resource.ironIngot));
	array_push(debugRecipes, new ResourceRecipe(Resource.goldIngot));

	array_push(debugRecipes, new ResourceRecipe(Resource.slime));
	array_push(debugRecipes, new ResourceRecipe(Resource.glass));
	array_push(debugRecipes, new ResourceRecipe(Resource.cloth));
	array_push(debugRecipes, new ResourceRecipe(Resource.cloud));
	array_push(debugRecipes, new ResourceRecipe(Resource.gem));
}
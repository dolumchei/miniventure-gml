function Workbench() : Furniture("Workbench") constructor
{
	col = global.Color.get(-1, 100, 321, 431); 
	sprite = 4; 
	xr = 3; 
	yr = 2; 

	static use2 = function(player, attackDir)
	{
		player.game.setMenu(new CraftingMenu(global.Crafting.workbenchRecipes, player)); 
		return true;
	}
}
function Workbench() : Furniture("Workbench") constructor
{
	col = Color.get(-1, 100, 321, 431); 
	sprite = 4; 
	xr = 3; 
	yr = 2; 

	use2 = function(player, attackDir)
	{
		player.game.setMenu(new CraftingMenu(Crafting.workbenchRecipes, player)); 
		return true;
	}
}
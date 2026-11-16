function Chest() : Furniture("Chest") constructor
{
	inventory = new Inventory();
	col = Color.get(-1, 110, 331, 552); 
	sprite = 1; 

	use2 = function(player, attackDir)
	{
		player.game.setMenu(new ContainerMenu(player, "Chest", inventory)); 
		return true;
	}
}
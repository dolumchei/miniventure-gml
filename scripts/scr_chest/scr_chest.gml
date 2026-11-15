function Chest() : Furniture("Chest") constructor
{
	inventory = new Inventory();
	col = global.Color.get(-1, 110, 331, 552); 
	sprite = 1; 

	static use2 = function(player, attackDir)
	{
		player.game.setMenu(new ContainerMenu(player, "Chest", inventory)); 
		return true;
	}
}
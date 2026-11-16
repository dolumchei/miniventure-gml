function FurnitureRecipe(clazz) : Recipe(["FurnitureItem", clazz]) constructor
{
	self.clazz = clazz;
	
	craft = function(player)
	{
		player.inventory.add(0, new FurnitureItem(new clazz())); 
	}	
}
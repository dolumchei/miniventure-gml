function ResourceRecipe(resource) : Recipe(["ResourceItem", resource, 1]) constructor
{
	self.resource = resource;
	craft = function(player)
	{
		player.inventory.add(0, new ResourceItem(resource, 1)); 
	}
}

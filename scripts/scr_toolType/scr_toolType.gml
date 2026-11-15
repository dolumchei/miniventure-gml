function singleton_ToolType(name, sprite, __singleton = false) constructor
{
	if (__singleton)
	{
		shovel = new singleton_ToolType("Shvl", 0);
		hoe = new singleton_ToolType("Hoe", 1);
		sword = new singleton_ToolType("Swrd", 2);
		pickaxe = new singleton_ToolType("Pick", 3);
		axe = new singleton_ToolType("Axe", 4);
	}
	
	self.name = name;
	self.sprite = sprite;
}

function Furniture(name) : Entity() constructor
{
	pushTime = 0; 
	pushDir = -1; 
	col = 0;
	sprite = 0;; 
	
	self.name = name; 
	xr = 3; 
	yr = 3;
		
	shouldTake = undefined; 

	static tick = function()
	{
		if (shouldTake != undefined)
		{ 
			if (is_instanceof(shouldTake.activeItem, PowerGloveItem))
			{ 
				remove(); 
				shouldTake.inventory.add(0, shouldTake.activeItem); 
				shouldTake.activeItem = new FurnitureItem(self); 
			}
			shouldTake = undefined; 
		}
		if (pushDir == 0)
			move(0, 1); 
		if (pushDir == 1)
			move(0, -1); 
		if (pushDir == 2)
			move(-1, 0); 
		if (pushDir == 3)
			move(+1, 0); 
		pushDir = -1; 
		if (pushTime > 0)
			pushTime--; 
	}
	static render = function(screen)
	{
		screen.render(x - 8, y - 8 - 4, sprite * 2 + 8 * 32, col, 0); 
		screen.render(x - 0, y - 8 - 4, sprite * 2 + 8 * 32 + 1, col, 0); 
		screen.render(x - 8, y - 0 - 4, sprite * 2 + 8 * 32 + 32, col, 0); 
		screen.render(x - 0, y - 0 - 4, sprite * 2 + 8 * 32 + 33, col, 0); 
	}
	static blocks = function(e)
	{
		return true; 
	}
	static touchedBy = function(entity)
	{
		if (is_instanceof(entity, Player) && pushTime == 0)
		{ 
			pushDir = (entity).dir; 
			pushTime = 10; 
		}
	}
	static take = function(player)
	{
		shouldTake = player; 
	}
	
	static tile_hurt4 = function(tile, xx, yy, damage) { }
}
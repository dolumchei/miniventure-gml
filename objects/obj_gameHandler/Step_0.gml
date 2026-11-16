// tick
tickCount++;
if (!window_has_focus())
	input.releaseAll();	
else
{
	if (!is_undefined(player))
	{
		if (!player.removed && !hasWon)
			gameTime++;
	}
		
	input.update();
		
	if (!is_undefined(menu))
		menu.tick();
	else
	{
		if (!is_undefined(player))
		{
			if (player.removed)
			{
				playerDeadTime++;
				if (playerDeadTime > 60)
					setMenu(new DeadMenu());
			}
			else
			{
				if (pendingLevelChange != 0)
				{
					setMenu(new LevelTransitionMenu(pendingLevelChange));
					pendingLevelChange = 0;
				}
			}
		}
			
		if (wonTimer > 0)
		{
			if (--wonTimer == 0)
				setMenu(new WonMenu());
		}
			
		if (!is_undefined(level))
			level.tick();
		Tile.tickCount++;
	}
}

if (keyboard_check_pressed(ord("M")) && global.config_debugMenu)
{
	if (is_undefined(menu) && !is_undefined(player))
		setMenu(new DebugMenu(player));
}
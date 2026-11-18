function Player(game, input) : Mob() constructor
{
	self.input = input; 
	attackTime = 0;
	attackDir = 0; 

	self.game = game; 
	inventory = new Inventory(); 
	attackItem = undefined; 
	activeItem = undefined; 
	staminaRecharge = 0; 
	staminaRechargeDelay = 0; 
	scoreValue = 0; 
	maxStamina = 10; 
	onStairDelay = 0; 
	invulnerableTime = 0; 
	
	x = 24;
	y = 24;
	stamina = maxStamina;
	
	inventory.add(new FurnitureItem(new Workbench())); 
	inventory.add(new PowerGloveItem()); 
	
	tick = function()
	{
		mob_tick(); 
		if (invulnerableTime > 0)
			invulnerableTime--; 
		var onTile = level.getTile(x >> 4, y >> 4); 
		
		if (onTile == Tile.stairsDown || onTile == Tile.stairsUp)
		{ 
			if (onStairDelay == 0)
			{ 
				changeLevel((onTile == Tile.stairsUp) ? 1 : -1); 
				onStairDelay = 10; 
				return; 
			}
			onStairDelay = 10; 
		} 
		else
		{
			if (onStairDelay > 0)
				onStairDelay--; 
		}

		if (stamina <= 0 && staminaRechargeDelay == 0 && staminaRecharge == 0)
			staminaRechargeDelay = 40; 

		if (staminaRechargeDelay > 0) 
			staminaRechargeDelay--; 

		if (staminaRechargeDelay == 0)
		{ 
			staminaRecharge++; 
			if (isSwimming()) 
				staminaRecharge = 0; 
			while (staminaRecharge > 10)
			{ 
				staminaRecharge -= 10; 
				if (stamina < maxStamina)
					stamina++; 
			}
		}

		var xa = 0; 
		var ya = 0; 
		if (input.up.down()) 
			ya--; 
		if (input.down.down())
			ya++; 
		if (input.left.down())
			xa--; 
		if (input.right.down())
			xa++; 
			
		if (isSwimming() && tickTime % 60 == 0)
		{
			if (stamina > 0)
			{
				if (!global.config_fullStamina)
					stamina--; 
			}
			else
				hurt3(self, 1, dir ^ 1); 
		}

		if (staminaRechargeDelay % 2 == 0)
			move(xa, ya); 

		if (input.attack.check())
		{
			if (stamina == 0) { }
			else	
			{
				if (!global.config_fullStamina)
					stamina--; 
				staminaRecharge = 0; 
				attack(); 
			}
		}
		
		if (input.menu.check())
		{ 
			if (!use0())
				game.setMenu(new InventoryMenu(self)); 
		}
		
		if (attackTime > 0)
			attackTime--; 

	}
	use0 = function()
	{
		if (dir == 0 && use4(x - 8, y + 4 - 2, x + 8, y + 12 - 2))
			return true; 
		if (dir == 1 && use4(x - 8, y - 12 - 2, x + 8, y - 4 - 2))
			return true; 
		if (dir == 3 && use4(x + 4, y - 8 - 2, x + 12, y + 8 - 2))
			return true; 
		if (dir == 2 && use4(x - 12, y - 8 - 2, x - 4, y + 8 - 2))
			return true; 
		return false;
	}
	attack = function()
	{
		walkDist += 8; 
		attackDir = dir; 
		attackItem = activeItem; 
		var done = false; 

		if (activeItem != undefined)
		{ 
			attackTime = 10; 
			var yo = -2; 
			var range = 12; 
			if (dir == 0 && interact4(x - 8, y + 4 + yo, x + 8, y + range + yo)) 
				done = true;
			if (dir == 1 && interact4(x - 8, y - range + yo, x + 8, y - 4 + yo))
				done = true;
			if (dir == 3 && interact4(x + 4, y - 8 + yo, x + range, y + 8 + yo))
				done = true;
			if (dir == 2 && interact4(x - range, y - 8 + yo, x - 4, y + 8 + yo))
				done = true;
			if (done)
				return; 

			var xt = x >> 4; 
			var yt = (y + yo) >> 4; 
			var r = 12; 
			if (attackDir == 0)
				yt = (y + r + yo) >> 4; 
			if (attackDir == 1)
				yt = (y - r + yo) >> 4; 
			if (attackDir == 2)
				xt = (x - r) >> 4; 
			if (attackDir == 3)
				xt = (x + r) >> 4; 

			if (xt >= 0 && yt >= 0 && xt < level.w && yt < level.h)
			{
				if (activeItem.interactOn(level.getTile(xt, yt), level, xt, yt, self, attackDir))
					done = true; 
				else
				{
					if (level.getTile(xt, yt).interact(level, xt, yt, self, activeItem, attackDir))
						done = true; 
				}
				if (activeItem.isDepleted())
					activeItem = undefined; 
			}
		}

		if (done)
			return; 

		if (activeItem == undefined || activeItem.canAttack())
		{ 
			attackTime = 5; 
			var yo = -2; 
			var range = 20; 
			if (dir == 0) 
				hurt4(x - 8, y + 4 + yo, x + 8, y + range + yo); 
			if (dir == 1)
				hurt4(x - 8, y - range + yo, x + 8, y - 4 + yo); 
			if (dir == 3)
				hurt4(x + 4, y - 8 + yo, x + range, y + 8 + yo); 
			if (dir == 2)
				hurt4(x - range, y - 8 + yo, x - 4, y + 8 + yo); 

			var xt = x >> 4; 
			var yt = (y + yo) >> 4; 
			var r = 12; 
			if (attackDir == 0)
				yt = (y + r + yo) >> 4; 
			if (attackDir == 1)
				yt = (y - r + yo) >> 4; 
			if (attackDir == 2)
				xt = (x - r) >> 4; 
			if (attackDir == 3)
				xt = (x + r) >> 4; 

			if (xt >= 0 && yt >= 0 && xt < level.w && yt < level.h) 
				level.getTile(xt, yt).hurt6(level, xt, yt, self, prandom.nextInt(3) + 1, attackDir); 
		}
	}
	use4 = function(x0, y0, x1, y1)
	{
		var entities = level.getEntities(x0, y0, x1, y1); 
		for (var i = 0; i < array_length(entities); i++)
		{
			var e = entities[i]; 
			if (e != self)
			{
				if (e.use2(self, attackDir))
					return true; 
			}
		}
		return false;
	}
	interact4 = function(x0, y0, x1, y1)
	{
		var entities = level.getEntities(x0, y0, x1, y1); 
		for (var i = 0; i < array_length(entities); i++)
		{ 
			var e = entities[i]; 
			if (e != self)
			{
				if (e.interact3(self, activeItem, attackDir))
					return true; 
			}
		}
		return false;
	}
	hurt4 = function(x0, y0, x1, y1)
	{
		var entities = level.getEntities(x0, y0, x1, y1); 
		for (var i = 0; i < array_length(entities); i++)
		{
			var e = entities[i]; 
			if (e != self)
				e.hurt3(self, getAttackDamage(e), attackDir); 
		}
	}
	getAttackDamage = function(e)
	{
		var dmg = prandom.nextInt(3) + 1; 
		if (attackItem != undefined)
			dmg += attackItem.getAttackDamageBonus(e); 
		return dmg;
	}
	render = function(screen)
	{
		var xt = 0; 
		var yt = 14; 

		var flip1 = (walkDist >> 3) & 1; 
		var flip2 = (walkDist >> 3) & 1; 

		if (dir == 1) 
			xt += 2; 
		if (dir > 1)
		{ 
			flip1 = 0; 
			flip2 = ((walkDist >> 4) & 1); 
			if (dir == 2)
				flip1 = 1; 
			xt += 4 + ((walkDist >> 3) & 1) * 2; 
		}

		var xo = x - 8; 
		var yo = y - 11; 
		if (isSwimming())
		{ 
			yo += 4; 
			var waterColor = Color.get(-1, -1, 115, 335); 
			if (tickTime / 8 % 2 <= 1)
				waterColor = Color.get(-1, 335, 5, 115); 
			screen.render(xo + 0, yo + 3, 5 + 13 * 32, waterColor, 0); 
			screen.render(xo + 8, yo + 3, 5 + 13 * 32, waterColor, 1); 
		}

		if (attackTime > 0 && attackDir == 1)
		{ 
			screen.render(xo + 0, yo - 4, 6 + 13 * 32, Color.get(-1, 555, 555, 555), 0); 
			screen.render(xo + 8, yo - 4, 6 + 13 * 32, Color.get(-1, 555, 555, 555), 1); 
			if (attackItem != undefined) 
				attackItem.renderIcon(screen, xo + 4, yo - 4); 
		}
		var col = Color.get(-1, 100, 220, 532); 
		if (hurtTime > 0)
			col = Color.get(-1, 555, 555, 555); 

		if (is_instanceof(activeItem, FurnitureItem))
			yt += 2; 

		screen.render(xo + 8 * flip1, yo + 0, xt + yt * 32, col, flip1); 
		screen.render(xo + 8 - 8 * flip1, yo + 0, xt + 1 + yt * 32, col, flip1); 
		if (!isSwimming())
		{ 
			screen.render(xo + 8 * flip2, yo + 8, xt + (yt + 1) * 32, col, flip2); 
			screen.render(xo + 8 - 8 * flip2, yo + 8, xt + 1 + (yt + 1) * 32, col, flip2); 
		}

		if (attackTime > 0 && attackDir == 2)
		{ 
			screen.render(xo - 4, yo, 7 + 13 * 32, Color.get(-1, 555, 555, 555), 1); 
			screen.render(xo - 4, yo + 8, 7 + 13 * 32, Color.get(-1, 555, 555, 555), 3); 
			if (attackItem != undefined) 
				attackItem.renderIcon(screen, xo - 4, yo + 4); 
		}
		if (attackTime > 0 && attackDir == 3)
		{ 
			screen.render(xo + 8 + 4, yo, 7 + 13 * 32, Color.get(-1, 555, 555, 555), 0); 
			screen.render(xo + 8 + 4, yo + 8, 7 + 13 * 32, Color.get(-1, 555, 555, 555), 2); 
			if (attackItem != undefined)
				attackItem.renderIcon(screen, xo + 8 + 4, yo + 4); 
		}
		if (attackTime > 0 && attackDir == 0)
		{
			screen.render(xo + 0, yo + 8 + 4, 6 + 13 * 32, Color.get(-1, 555, 555, 555), 2); 
			screen.render(xo + 8, yo + 8 + 4, 6 + 13 * 32, Color.get(-1, 555, 555, 555), 3); 
			if (attackItem != undefined) 
				attackItem.renderIcon(screen, xo + 4, yo + 8 + 4); 
		}

		if (is_instanceof(activeItem, FurnitureItem))
		{ 
			var furniture = (activeItem).furniture; 
			furniture.x = x; 
			furniture.y = yo; 
			furniture.render(screen);
		}
	}
	touchItem = function(itemEntity)
	{
		itemEntity.take(self); 
		inventory.add(itemEntity.item); 
	}
	canSwim = function()
	{
		return true; 
	}
	findStartPos = function(level)
	{
		while (true)
		{ 
			var px = prandom.nextInt(level.w); 
			var py = prandom.nextInt(level.h); 
			if (level.getTile(px, py) == Tile.grass)
			{ 
				self.x = px * 16 + 8; 
				self.y = py * 16 + 8; 
				return true; 
			}
		}
	}
	payStamina = function(cost)
	{
		if (cost > stamina)
			return false; 
		if (!global.config_fullStamina)
			stamina -= cost; 
		return true; 
	}
	changeLevel = function(dir)
	{
		game.scheduleLevelChange(dir); 
	}
	getLightRadius = function()
	{
		var r = 2; 
		if (activeItem != undefined)
		{ 
			if (is_instanceof(activeItem, FurnitureItem))
			{ 
				var rr = (activeItem).furniture.getLightRadius(); 
				if (rr > r)
					r = rr; 
			} 
		}
		return r; 
	}
	die = function()
	{
		mob_die(); 
		Sound.playerDeath.play(); 
	}
	touchedBy = function(entity)
	{
		if (!is_instanceof(entity, Player))
			entity.touchedBy(self); 
	}
	doHurt = function(damage, attackDir)
	{
		if (hurtTime > 0 || invulnerableTime > 0)
			return; 

		Sound.playerHurt.play(); 
		level.add(new TextParticle(string(damage), x, y, Color.get(-1, 504, 504, 504))); 
		
		if (!global.config_noDamage)
			healthValue -= damage; 
		
		if (attackDir == 0)
			yKnockback = 6; 
		if (attackDir == 1)
			yKnockback = -6; 
		if (attackDir == 2)
			xKnockback = -6; 
		if (attackDir == 3)
			xKnockback = 6; 
		hurtTime = 10; 
		invulnerableTime = 30; 
	}
	gameWon = function()
	{
		level.player.invulnerableTime = 60 * 5; 
		game.won(); 
	}
}
//intial release 20-06-2026 by Fxyz, Last update: 20-06-2026

state("Enotria-Win64-Shipping", "1.005.26813")
{
	int loadValue: 0x85C9958;
	int BossKill: 0x84B4730, 0xD8, 0x20, 0x18, 0x250, 0x80, 0x10, 0x98;
	byte Credits: 0x88BCA71;
	int mainMenu: 0x865C280, 0x8;
	byte reset: 0x81F5650;
	float playerHP: 0x861DBB8, 0x0, 0x20, 0x218, 0x220, 0x48;
	double xCoord: 0x861DBB8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x861DBB8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x861DBB8, 0x0, 0x20, 0x218, 0x0, 0x200;
}

state("Enotria-Win64-Shipping", "1.007.28161")
{
	int loadValue: 0x85F8758;
	int BossKill: 0x84E3530, 0xD8, 0x20, 0x18, 0x250, 0x80, 0x10, 0x98;
	byte Credits: 0x88EC461;
	int mainMenu: 0x8868B0A0, 0x8;
	byte reset: 0x85E48BB;
	float playerHP: 0x864C9A8, 0x0, 0x20, 0x218, 0x220, 0x48;
	double xCoord: 0x864C9A8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x864C9A8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x864C9A8, 0x0, 0x20, 0x218, 0x0, 0x200;
}


state("Enotria-Win64-Shipping", "1.008.28601")
{
	int loadValue: 0x873C258;
	int BossKill: 0x8627030, 0xD8, 0x20, 0x18, 0x250, 0x80, 0x10, 0x98;
	byte Credits: 0x8A360C1;
	int mainMenu: 0x87CEBB0, 0x8;
	byte reset: 0x835F650;
	float playerHP: 0x87904B8, 0x0, 0x20, 0x218, 0x220, 0x48;
	double xCoord: 0x87904B8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x87904B8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x87904B8, 0x0, 0x20, 0x218, 0x0, 0x200;
}

state("Enotria-Win64-Shipping", "1.009.28831")
{
	int loadValue: 0x8751898;
	int BossKill: 0x863C300, 0xD8, 0x20, 0x18, 0x250, 0x80, 0x10, 0x98;
	byte Credits: 0x8A49D81;
	int mainMenu: 0x87E41D0, 0x8;
	byte reset: 0x8375440;										
	float playerHP: 0x87A5AE8, 0x0, 0x20, 0x218, 0x220, 0x48;
	double xCoord: 0x87A5AE8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x87A5AE8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x87A5AE8, 0x0, 0x20, 0x218, 0x0, 0x200;
}

startup
{
	settings.Add("line1", true, "Only the following versions are supported");
	settings.Add("line2", true, "Check the guide section on speedrun.com for a downpatch guide");
	settings.Add("line3", true, "1.005.26813");
	settings.Add("line4", true, "1.007.28161");
	settings.Add("line5", true, "1.008.28601");
	settings.Add("line6", true, "1.009.28831");
}

init
{
	string MD5Hash;
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var stream = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			var hash = md5.ComputeHash(stream);
			MD5Hash = BitConverter.ToString(hash).Replace("-", "").ToUpperInvariant();
		}
	}

	switch (MD5Hash)
	{
		case "2C83BAC79D66B845BE6D967F10CE38AE":
			version = "1.005.26813"; break;

		case "17D974EA883D8B0FAE351FD01E41C92B":
			version = "1.007.28161"; break;
			
		case "A3926FA8E095F3CC1C10237DB698A4A2":
			version = "1.008.28601"; break;

		case "C97DFEA541733527B487534BF8C08A5E":
			version = "1.009.28831"; break;
			
		default:
			version = "Unsupported version"; break;
	}

	vars.bossRooms = new List<object[]>
	{
		// Spaventa (index 0)
		new object[] { "rect", 49030.0, 298861.0, 55475.0, 296063.0, 53761.0, 292115.0, 40500.0, 45000.0 },

		// Pantalone & Balanzone (index 1)
		new object[] { "rect", 135711.0, -421574.0, 136778.0, -418762.0, 141339.0, -420493.0, 20600.0, 25000.0 },

		// Giangurgolo (index 2)
		new object[] { "circle", 26825.0, 356557.0, 3537.0, 15600.0, 20000.0 },
	};

	// Rooms with cutscene entry that TP the player out of the room
	vars.roomsWithCutscene = new System.Collections.Generic.HashSet<int> { 1, 2 };

	vars.inEarlyTpBossRoom   = false;
	vars.playerDiedInRoom    = false;
	vars.pendingEarlyTpSplit = false;
	vars.currentRoomIndex    = -1;
	vars.splitDoneRooms      = new System.Collections.Generic.HashSet<int>();
	vars.lastTimerPhase      = "";
	vars.splitPendingTick    = -1;
	// -1 = no active cooldown, else = TickCount at the beginning of the cutscene cooldown
	vars.cutsceneCooldownTick = -1;
	vars.cutsceneHandled = new System.Collections.Generic.HashSet<int>();
	vars.reset               = 0;
}


update
{
	string currentPhase = timer.CurrentPhase.ToString();
	if (currentPhase == "Running" && ((string)vars.lastTimerPhase == "NotRunning" || (string)vars.lastTimerPhase == "Ended"))
	{
		vars.inEarlyTpBossRoom    = false;
		vars.playerDiedInRoom     = false;
		vars.pendingEarlyTpSplit  = false;
		vars.currentRoomIndex     = -1;
		vars.splitDoneRooms.Clear();
		vars.splitPendingTick     = -1;
		vars.cutsceneCooldownTick = -1;
		vars.cutsceneHandled.Clear();
	}
	vars.lastTimerPhase = currentPhase;

	if (vars.bossRooms == null) return;

	double x = current.xCoord;
	double y = current.yCoord;
	double z = current.zCoord;

	// If a split is waiting for validation
	if ((int)vars.splitPendingTick != -1)
	{
		if (current.mainMenu == 1)
		{
			vars.splitPendingTick    = -1;
			vars.inEarlyTpBossRoom   = false;
			vars.playerDiedInRoom    = false;
			vars.splitDoneRooms.Remove(vars.currentRoomIndex);
			vars.currentRoomIndex    = -1;
			vars.cutsceneCooldownTick = -1;
		}
		else if (Environment.TickCount - (int)vars.splitPendingTick >= 100)
		{
			vars.splitPendingTick    = -1;
			vars.pendingEarlyTpSplit = true;
		}
		return;
	}

	// If the cutscene cooldwon is active, ignore split for 3 seconds
	if ((int)vars.cutsceneCooldownTick != -1)
	{
		if (Environment.TickCount - (int)vars.cutsceneCooldownTick >= 3000)
		{
			// Cooldown terminé → on reprend la logique normale
			vars.cutsceneCooldownTick = -1;
		}
		else
		{
			return;
		}
	}

	// Current room we're in
	int currentRoomIndex = -1;
	for (int i = 0; i < vars.bossRooms.Count; i++)
	{
		var room = (object[])vars.bossRooms[i];
		string type = (string)room[0];
		bool inRoom = false;

		if (type == "rect")
		{
			double c1x  = (double)room[1], c1y  = (double)room[2];
			double c2x  = (double)room[3], c2y  = (double)room[4];
			double c3x  = (double)room[5], c3y  = (double)room[6];
			double zMin = (double)room[7], zMax  = (double)room[8];

			if (z >= zMin && z <= zMax)
			{
				double ux = c2x - c1x, uy = c2y - c1y;
				double lenU = Math.Sqrt(ux * ux + uy * uy);
				ux /= lenU; uy /= lenU;

				double vx = c3x - c2x, vy = c3y - c2y;
				double lenV = Math.Sqrt(vx * vx + vy * vy);
				vx /= lenV; vy /= lenV;

				double dx = x - c1x, dy = y - c1y;
				double projU = dx * ux + dy * uy;
				double projV = dx * vx + dy * vy;

				inRoom = projU >= 0 && projU <= lenU &&
						 projV >= 0 && projV <= lenV;
			}
		}
		else if (type == "circle")
		{
			double cx   = (double)room[1], cy   = (double)room[2];
			double r    = (double)room[3];
			double zMin = (double)room[4], zMax = (double)room[5];

			if (z >= zMin && z <= zMax)
			{
				double dx = x - cx, dy = y - cy;
				inRoom = (dx * dx + dy * dy) <= (r * r);
			}
		}

		if (inRoom) { currentRoomIndex = i; break; }
	}

	bool currentlyInRoom = currentRoomIndex != -1;

	// Enterning the room
	if (currentlyInRoom && !vars.inEarlyTpBossRoom)
	{
		vars.inEarlyTpBossRoom    = true;
		vars.currentRoomIndex     = currentRoomIndex;
		vars.playerDiedInRoom     = false;
		vars.cutsceneCooldownTick = -1;
	}

	// Is player dead during the fight
	if (vars.inEarlyTpBossRoom && current.playerHP <= 0)
	{
		vars.playerDiedInRoom = true;
	}

	// Exiting the room
	if (vars.inEarlyTpBossRoom)
	{
		if (current.mainMenu == 1)
		{
			vars.inEarlyTpBossRoom    = false;
			vars.playerDiedInRoom     = false;
			vars.splitPendingTick     = -1;
			vars.cutsceneCooldownTick = -1;
			vars.cutsceneHandled.Remove(vars.currentRoomIndex);
			vars.splitDoneRooms.Remove(vars.currentRoomIndex);
			vars.currentRoomIndex     = -1;
		}
		else if (!currentlyInRoom)
		{
			int idx = vars.currentRoomIndex;
			bool hasCutscene    = vars.roomsWithCutscene.Contains(idx);
			bool alreadyHandled = vars.cutsceneHandled.Contains(idx);

			if (hasCutscene && !alreadyHandled)
			{
				// 1st exit → cutscene cooldown
				vars.cutsceneHandled.Add(idx);
				vars.cutsceneCooldownTick = Environment.TickCount;
			}
			else
			{
				// True exit → split
				vars.inEarlyTpBossRoom    = false;
				vars.cutsceneCooldownTick = -1;
				bool alreadySplit = vars.splitDoneRooms.Contains(idx);
				if (!vars.playerDiedInRoom && !alreadySplit)
				{
					vars.splitDoneRooms.Add(idx);
					vars.splitPendingTick = Environment.TickCount;
				}
			}
		}
	}
}


start
{
	if(current.mainMenu == 259 && current.loadValue == 1 && old.loadValue == 50)
	{
		vars.inEarlyTpBossRoom    = false;
		vars.playerDiedInRoom     = false;
		vars.pendingEarlyTpSplit  = false;
		vars.currentRoomIndex     = -1;
		vars.splitDoneRooms.Clear();
		vars.splitPendingTick     = -1;
		vars.cutsceneCooldownTick = -1;
		vars.cutsceneHandled.Clear();
		vars.reset = 0;
		return true;
	}
}


split
{
	refreshRate = 100;

	if (vars.pendingEarlyTpSplit)
	{
		vars.pendingEarlyTpSplit = false;
		return true;
	}

	if (vars.inEarlyTpBossRoom)
	{
		return false;
	}

	//Mid Bosses

	if(current.BossKill == 1139494091 && old.BossKill == 0 || current.BossKill == 1139489782 && old.BossKill == 0)
	{
		return true;
	}

	//Goddesses
	
	if(current.BossKill == 1140654079 && old.BossKill == 0 || current.BossKill == 1140572209 && old.BossKill == 0)
	{
		return true;
	}

	//Major Bosses (without Spaventa, Giangurgolo and Pantalone & Balanzone)
	
	if(current.BossKill == 1143033037 && old.BossKill == 0 || current.BossKill == 1143023905 && old.BossKill == 0)
	{
		return true;
	}

	//Credits
	if(version == "1.005.26813")
	{
		if(current.Credits == 30 && old.Credits != 30)
		{
			return true;
		}
	}
	if(version == "1.007.28161")
	{
		if(current.Credits == 28 && old.Credits != 28)
		{
			return true;
		}
	}
	if(version == "1.008.28601" || version == "1.009.28831")
	{
		if(current.Credits == 105 && old.Credits != 105)
		{
			return true;
		}
	}



	//Protection against unwanted resets
	if(current.mainMenu == 1 && current.xCoord == 0 && current.yCoord == 0 && vars.reset == 0)
	{
		vars.reset = 1;
	}
	if(vars.reset == 1 && current.loadValue == 1 && old.loadValue == 50)
	{
		vars.reset = 0;
	}
   
}


reset
{
	if(version == "1.005.26813")
	{
		if(vars.reset == 1 && current.mainMenu == 259 && current.reset == 19)
		{
			vars.inEarlyTpBossRoom    = false;
			vars.playerDiedInRoom     = false;
			vars.pendingEarlyTpSplit  = false;
			vars.currentRoomIndex     = -1;
			vars.splitDoneRooms.Clear();
			vars.splitPendingTick     = -1;
			vars.cutsceneCooldownTick = -1;
			vars.reset                = 0;
			vars.cutsceneHandled.Clear();
			return true;
		}
	}
	if(version == "1.007.28161"|| version == "1.008.28601" || version == "1.009.28831")
	{
		if(vars.reset == 1 && current.mainMenu == 259 && current.reset == 20)
		{
			vars.inEarlyTpBossRoom    = false;
			vars.playerDiedInRoom     = false;
			vars.pendingEarlyTpSplit  = false;
			vars.currentRoomIndex     = -1;
			vars.splitDoneRooms.Clear();
			vars.splitPendingTick     = -1;
			vars.cutsceneCooldownTick = -1;
			vars.reset                = 0;
			vars.cutsceneHandled.Clear();
			return true;
		}
	}
}


isLoading
{
	return current.loadValue == 50; 
}
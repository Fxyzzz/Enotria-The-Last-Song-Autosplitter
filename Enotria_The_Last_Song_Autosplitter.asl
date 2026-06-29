//intial release 20-06-2026 by Fxyz, Last update: 29-06-2026

state("Enotria-Win64-Shipping", "1.005.26813")
{
	int loadValue: 0x85C9958;
	byte inCombat: 0x88BC218, 0x34;
	byte credits: 0x88BCA71;
	int mainMenu: 0x865C280, 0x8;
	byte reset: 0x81F5650;
	double xCoord: 0x861DBB8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x861DBB8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x861DBB8, 0x0, 0x20, 0x218, 0x0, 0x200;
}

state("Enotria-Win64-Shipping", "1.007.28161")
{
	int loadValue: 0x85F8758;
	byte inCombat: 0x88EBC08, 0x34;
	byte credits: 0x88EC461;
	int mainMenu: 0x8868B0A0, 0x8;
	byte reset: 0x85E48BB;
	double xCoord: 0x864C9A8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x864C9A8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x864C9A8, 0x0, 0x20, 0x218, 0x0, 0x200;
}


state("Enotria-Win64-Shipping", "1.008.28601")
{
	int loadValue: 0x873C258;
	byte inCombat: 0x8A35868, 0x34;
	byte credits: 0x8A360C1;
	int mainMenu: 0x87CEBB0, 0x8;
	byte reset: 0x835F650;
	double xCoord: 0x87904B8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x87904B8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x87904B8, 0x0, 0x20, 0x218, 0x0, 0x200;
}

state("Enotria-Win64-Shipping", "1.009.28831")
{
	int loadValue: 0x8751898;
	byte inCombat: 0x8A49528, 0x34;
	byte credits: 0x8A49D81;
	int mainMenu: 0x87E41D0, 0x8;
	byte reset: 0x8375440;										
	double xCoord: 0x87A5AE8, 0x0, 0x20, 0x218, 0x0, 0x1F0;
	double yCoord: 0x87A5AE8, 0x0, 0x20, 0x218, 0x0, 0x1F8;
	double zCoord: 0x87A5AE8, 0x0, 0x20, 0x218, 0x0, 0x200;
}

startup
{
	settings.Add("line1", true, "Autosplits will trigger after every boss kill and on the credits");
	settings.Add("line2", true, "(except for Pulcinella for which the split will happen on the credits)");
	settings.Add("line3", true, "Only the following versions are supported");
	settings.Add("line4", true, "Check out the Guides section on speedrun.com for a downpatch guide");
	settings.Add("line5", true, "1.005.26813");
	settings.Add("line6", true, "1.007.28161");
	settings.Add("line7", true, "1.008.28601");
	settings.Add("line8", true, "1.009.28831");
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

	vars.reset = 0;
	vars.doNotSplit = 0;
	vars.doNotSplitRegion = 0;
	vars.AstrariumAscendant = 0;
	vars.Spaventa = 0;
}


start
{
	if(current.mainMenu == 259 && current.loadValue == 1 && old.loadValue == 50)
	{
		vars.reset = 0;
		vars.doNotSplit = 0;
		vars.doNotSplitRegion = 0;
		vars.AstrariumAscendant = 0;
		vars.Spaventa = 0;
		return true;
	}
}


split
{
	refreshRate = 100;


	//protection against unwanted splits
	
	
	//When going back to main menu
	
	if(current.xCoord == 0 && current.yCoord == 0 && old.inCombat == 1 && current.inCombat == 0 && vars.doNotSplit == 0)
	{
		vars.doNotSplit = 1;
	}
	
	if(current.xCoord != 0 && current.yCoord != 0 && vars.doNotSplit == 1)
	{
		vars.doNotSplit = 0;
	}
	
	
	//When entering Falesia
	
	if(current.xCoord > -17331.6 && current.xCoord < -16801.1 && current.yCoord > 39030.5 && current.yCoord < 408123.0 && current.zCoord > 9400.0 && current.zCoord < 9800.0 && vars.doNotSplitRegion == 0)
	{
		vars.doNotSplitRegion = 1;
	}
	
	if(current.xCoord > -40365.8 && current.xCoord < -39063.4 && current.yCoord > 330386.7 && current.yCoord < 331108.7 && current.zCoord > 17500.0 && current.zCoord < 17700.0 && vars.doNotSplitRegion == 1)
	{
		vars.doNotSplitRegion = 0;
	}
	
	
	//When entering Litumnia
	
	if(current.xCoord > 859.8 && current.xCoord < 910.6 && current.yCoord > -27406.2 && current.yCoord < -27069.1 && current.zCoord > 7410.0 && current.zCoord < 7450.0 && vars.doNotSplitRegion == 0)
	{
		vars.doNotSplitRegion = 1;
	}
	
	if(current.xCoord > 113811.8 && current.xCoord < 113917.1 && current.yCoord > -508863.1 && current.yCoord < -508429.6 && current.zCoord > 26160.0 && current.zCoord < 26200.0 && vars.doNotSplitRegion == 1)
	{
		vars.doNotSplitRegion = 0;
	}
	
	
	//Astrarium Ascendant case (since can be defeated while out of combat)
	
	if(current.xCoord > 96412.9 && current.xCoord < 96603.7 && current.yCoord > -463346.9 && current.yCoord < -461863.1 && current.zCoord > 26270.0 && current.zCoord < 27000.0 && vars.AstrariumAscendant == 0)
	{
		vars.AstrariumAscendant = 1;
	}
	if(vars.AstrariumAscendant == 1 && current.inCombat != old.inCombat && vars.doNotSplit == 0)
	{
		vars.AstrariumAscendant = 0;
		return true;
	}


	//Spaventa case (cause he has a fake death which makes us go out of combat)
	
	if(current.xCoord > 52954.0 && current.xCoord < 52964.0 && current.yCoord > 294816.0 && current.yCoord < 294820.0 && current.zCoord > 40660.0 && current.zCoord < 40665.0 && vars.AstrariumAscendant == 0)
	{
		vars.Spaventa = 1;
	}
	if(vars.Spaventa == 1 && current.inCombat == 0 && old.inCombat == 1 && vars.doNotSplit == 0)
	{
		vars.Spaventa = 2;
	}
	if(vars.Spaventa == 2 && current.inCombat == 1 && old.inCombat == 0 && vars.doNotSplit == 0)
	{
		vars.Spaventa = 0 ;
	}


	//All Bosses (without Astrarium Ascendant)

	if(current.inCombat == 0 && old.inCombat == 1 && vars.doNotSplit == 0 && vars.AstrariumAscendant == 0 && vars.Spaventa == 0 && vars.doNotSplitRegion == 0)
	{
		return true;
	}


	//credits
	
	if(version == "1.005.26813")
	{
		if(current.credits == 30 && old.credits != 30)
		{
			return true;
		}
	}
	if(version == "1.007.28161")
	{
		if(current.credits == 28 && old.credits != 28)
		{
			return true;
		}
	}
	if(version == "1.008.28601" || version == "1.009.28831")
	{
		if(current.credits == 105 && old.credits != 105)
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
			vars.reset = 0;
			vars.doNotSplit = 0;
			vars.doNotSplitRegion = 0;
			vars.AstrariumAscendant = 0;
			vars.Spaventa = 0;
			return true;
		}
	}
	if(version == "1.007.28161"|| version == "1.008.28601" || version == "1.009.28831")
	{
		if(vars.reset == 1 && current.mainMenu == 259 && current.reset == 20)
		{
			vars.reset = 0;
			vars.doNotSplit = 0;
			vars.doNotSplitRegion = 0;
			vars.AstrariumAscendant = 0;
			vars.Spaventa = 0;
			return true;
		}
	}
}


isLoading
{
	return current.loadValue == 50; 
}

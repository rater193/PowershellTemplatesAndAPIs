
$MenuDungeonMasterManager = $api.createMenu.Invoke("DungeonMasterManager")

# Add a title
$MenuDungeonMasterManager.addTitle.Invoke("DM Manager CLI")

# Lines
$MenuDungeonMasterManager.addLine.Invoke("Select an option")

# Options
$MenuDungeonMasterManager.addOption.Invoke("Back"           , "0"   , "MainMenu")
$MenuDungeonMasterManager.addOption.Invoke("Items"          , "1"   , "Items")
$MenuDungeonMasterManager.addOption.Invoke("Monsters"       , "2"   , "Monsters")
$MenuDungeonMasterManager.addOption.Invoke("Maps"           , "3"   , "Maps")
$MenuDungeonMasterManager.addOption.Invoke("Traps"          , "4"   , "Traps")
$MenuDungeonMasterManager.addOption.Invoke("Loot Tables"    , "5"   , "Loot Tables")
$MenuDungeonMasterManager.addOption.Invoke("Dice Rolls"     , "6"   , "Dice Rolls")
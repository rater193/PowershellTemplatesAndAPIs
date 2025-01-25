
# Create a menu
$global:MenuMain = $api.createMenu.Invoke("MainMenu")

# Add a title
$MenuMain.addTitle.Invoke("DM Companion CLI")

# Add lines
$MenuMain.addLine.Invoke("Welcome Dungeon Master, to the Dungeon Master's 3E Companion. Please select one of the options below to begin using the CLI")
$MenuMain.addLine.Invoke("")
$MenuMain.addLine.Invoke("Line3")

# Add options
$MenuMain.addOption.Invoke("Start", "1", "MainMenu")
$MenuMain.addOption.Invoke("Options", "2", "MainMenu")
$MenuMain.addOption.Invoke("Dungeon Master Data Manager", "3", "DungeonMasterManager")
$MenuMain.addOption.Invoke("Exit", "4", "exit")
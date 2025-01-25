
# Create a menu
$global:MenuMain = $api.createMenu.Invoke("MainMenu")

# Add a title
$MenuMain.addTitle.Invoke("School IT Companion CLI")

# Add lines
$MenuMain.addLine.Invoke("Welcome to the School IT Companion. Please chose one of the following options to get started.")

# Add options
$MenuMain.addOption.Invoke("Start", "1", "MainMenu")
$MenuMain.addOption.Invoke("Exit", "9", "exit")
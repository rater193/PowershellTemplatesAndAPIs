
$folderPath = ".\data\Menus"

$scriptFiles = Get-ChildItem -Path $folderPath -Filter *.ps1

foreach($file in $scriptFiles) {
    . $file.FullName
}
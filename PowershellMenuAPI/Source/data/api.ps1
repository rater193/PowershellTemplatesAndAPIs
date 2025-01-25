# Initialize the API
function global:Write-WrappedHost {
    param (
        [string]$Text,
        [int]$LineWidth = $Host.UI.RawUI.WindowSize.Width  # Default to console width
    )

    # Split the text into chunks that fit within the specified line width
    $chunks = $Text -split "(.{1,$LineWidth})(?:\s|$)" | Where-Object { $_ -ne "" }

    # Write each chunk to the console
    foreach ($chunk in $chunks) {
        Write-Host $chunk
    }
}

$global:api = @{
    menus = @{} # Registry for menus

    createMenu = {
        param([string]$menuName)

        # Define the menu as a custom object
        $menu = New-Object PSObject -Property @{
            ConfigTitle = ""
            ConfigLines = @()
            ConfigOptions = @()
        }

        # Add a title to the menu
        $menu | Add-Member -MemberType ScriptMethod -Name addTitle -Value {
            param([string]$title)
            $this.ConfigTitle = $title
        }

        # Add a line to the menu
        $menu | Add-Member -MemberType ScriptMethod -Name addLine -Value {
            param([string]$line)
            $this.ConfigLines += $line
        }

        # Clear lines from the menu
        $menu | Add-Member -MemberType ScriptMethod -Name clearLines -Value {
            $this.ConfigLines = @()
        }

        # Clear lines from the menu
        $menu | Add-Member -MemberType ScriptMethod -Name clearLines -Value {
            $this.ConfigLines = @()
        }

        # Add an option to the menu
        $menu | Add-Member -MemberType ScriptMethod -Name addOption -Value {
            param([string]$line, [string]$optionKeybind, [string]$targetMenu)
            $this.ConfigOptions += [PSCustomObject]@{
                OptionLine = $line
                OptionKey = $optionKeybind
                OptionMenu = $targetMenu
            }
        }
        $apiTargetedMenu = $null  # Declare the variable outside the script block

        $menu | Add-Member -MemberType ScriptMethod -Name show -Value {
            ####################################################################
            #                              HEADER                              #
            ####################################################################
            # Writing the title
            Clear-Host
            Write-Host $this.ConfigTitle

            # Followed by lines
            Write-Host ""
            foreach ($line in $this.ConfigLines) {
                Write-WrappedHost -Text $line
            }
            
            # And finally the menu options
            Write-Host ""
            Write-Host "`nOptions:"
            foreach ($option in $this.ConfigOptions) {
                Write-WrappedHost -Text "[$($option.OptionKey)] $($option.OptionLine)"
            }


            ####################################################################
            #                              INPUT                               #
            ####################################################################
            $menuOption = Read-Host("Select an option: ")
            Set-Variable -Scope Global -Name apiTargetedMenu -Value "null"

            foreach ($option in $this.ConfigOptions) {
                if ($menuOption -eq $option.OptionKey) {
                    Set-Variable -Scope Global -Name apiTargetedMenu -Value $option.OptionMenu
                }
            }

            Write-Host "Target menu:"
            Write-Host $apiTargetedMenu
            

            switch($apiTargetedMenu) {
                "null" {
                    Clear-Host
                    Write-Host "Option not available"
                    PAUSE
                    $this.show.Invoke()
                }
                
                "exit" {
                    Clear-Host
                }
                
                default {
                    if($api.menus[$apiTargetedMenu]) {
                        $api.menus[$apiTargetedMenu].show.Invoke()
                    }else{
                        Write-Host "Missing menu target: $($apiTargetedMenu)"
                        PAUSE
                        $this.show.Invoke()
                    }
                }
            }
        }

        # Register the menu in the global menu registry
        $api.menus[$menuName] = $menu

        return $menu
    }
}
# =============================================================================
# File Name: Wi-Fi Config Export Tool.ps1
# =============================================================================
# Name: Wi-Fi Config Export Tool
# Author: Zak Clifford 
# Contact:  z.clifford[at]computeam.co.uk
# Version 1.0
# Created: 10 Jul 2019
# Updated: N/A
# Description: Exports the Inputted WiFi SSID profile including the PSK with multiple options
# =============================================================================
# Function Change Log
# v1.0 - Creation of script
# =============================================================================
$ver = "1.0"

# =============================================================================
# START OF CODE
# =============================================================================

function Show-Menu
{
     param (
           [string]$Title = 'Wi-Fi Config Export Tool - Main Menu'
     )
     cls
     Write-Host "================ $Title ================"
     
     Write-Host "1: Press '1' to display the WiFi SSID PSK." 
     Write-Host "2: Press '2' to output the details to a file (Basic)."
     Write-Host "3: Press '3' to output the details to a file (Advanced)."
     Write-Host "Q: Press 'Q' to quit."
}

do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                cls
                'You chose option #1 - display the WiFi SSID PSK.'
                    ## Prompts the User to input SSID
                    Add-Type -AssemblyName Microsoft.VisualBasic
                    $SSID = [Microsoft.VisualBasic.Interaction]::InputBox("Please enter the WiFi SSID Name", "Wi-Fi Export Tool", "Enter Here")

                    ## Outputs the Details in the Details variable ready for export
                    $DETAILS = netsh wlan show profile $SSID key=clear

                    $SSIDSearchResult = $DETAILS | Select-String -Pattern 'SSID Name'
                    $ProfileName = ($SSIDSearchResult -split ":")[-1].Trim() -replace '"'

                    $PSKSearchResult = $DETAILS | Select-String -Pattern 'Key Content'
                    $PSK = ($PSKSearchResult -split ":")[-1].Trim() -replace '"'

                    Write-Host "=============================================================================="
                    Write-Host "Wi-Fi Config Export Tool has now completed!"
                    Write-Host "`n"
                    Write-Host "The SSID you specified is: $ProfileName" -ForegroundColor Green
                    Write-Host "The Pre Shared Key is: $PSK" -ForegroundColor Green
                    Write-Host "`n"
                    Write-Host "=============================================================================="
                    Read-Host "Press [ENTER] to go back to the main menu..."
                    Write-Host "`n"
           } '2' {
                cls
                'You chose option #2 - output the details to a file (Basic).'


                ## Prompts the User to input SSID
                Add-Type -AssemblyName Microsoft.VisualBasic
                $SSID = [Microsoft.VisualBasic.Interaction]::InputBox("Please enter the WiFi SSID Name", "Wi-Fi Export Tool", "Enter Here")
                
                    ## Outputs the Details in the Details variable ready for export
                    $DETAILS = netsh wlan show profile $SSID key=clear

                    $SSIDSearchResult = $DETAILS | Select-String -Pattern 'SSID Name'
                    $ProfileName = ($SSIDSearchResult -split ":")[-1].Trim() -replace '"'

                    $PSKSearchResult = $DETAILS | Select-String -Pattern 'Key Content'
                    $PSK = ($PSKSearchResult -split ":")[-1].Trim() -replace '"'

                        ## Creates a new object with the selected basic values in it
                        $BasicOutput = [PSCustomObject] @{
                                        WiFi_Profile_Name = $ProfileName
                                        Pre_Shared_Key = $PSK
                                        }

                            Write-Host "=============================================================================="
                            Write-Host "Now specify the output location!"
                            Write-Host "`n"
                            Write-Host "=============================================================================="
                            Read-Host "Press [ENTER] to go continue..."
                            Write-Host "`n"

                                function Find-Folders {
                                [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                                [System.Windows.Forms.Application]::EnableVisualStyles()
                                $browse = New-Object System.Windows.Forms.FolderBrowserDialog
                                $browse.SelectedPath = "C:\"
                                $browse.ShowNewFolderButton = $false
                                $browse.Description = "Select a directory"
                                    $loop = $true
                                    while($loop)
                                    {
                                    if ($browse.ShowDialog() -eq "OK")
                                        {
                                        $loop = $false
		
		                                #Insert your script here
		
                                        } else
                                            {
                                            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
                                            if($res -eq "Cancel")
                                                {
                                                   #Ends script
                                                    return
                                                        }
                                                     }
                                                 }
                                    $browse.SelectedPath
                                    $browse.Dispose()
                                    }  
                            $DIR = Find-Folders

                           ## Outputs the SSID details required for WiFi Install
                            echo $BasicOutput > $DIR\$SSID.txt


                            Write-Host "`n"
                            Write-Host "The SSID you specified is: $ProfileName" -ForegroundColor Green
                            Write-Host "The Output is saved in:- $Dir" -ForegroundColor Green
                            Write-Host "`n"
                            Write-Host "=============================================================================="
                            Read-Host "Press [ENTER] to go back to the main menu..."
                            Write-Host "`n"





           } '3' {
                cls
                'You chose option #3 - output the details to a file (Advanced).'

                ## Prompts the User to input SSID
                Add-Type -AssemblyName Microsoft.VisualBasic
                $SSID = [Microsoft.VisualBasic.Interaction]::InputBox("Please enter the WiFi SSID Name", "Wi-Fi Export Tool", "Enter Here")
                
                    ## Outputs the Details in the Details variable ready for export
                    $DETAILS = netsh wlan show profile $SSID key=clear

                    $SSIDSearchResult = $DETAILS | Select-String -Pattern 'SSID Name'
                    $ProfileName = ($SSIDSearchResult -split ":")[-1].Trim() -replace '"'

                    $PSKSearchResult = $DETAILS | Select-String -Pattern 'Key Content'
                    $PSK = ($PSKSearchResult -split ":")[-1].Trim() -replace '"'

                        ## Creates a new object with the selected basic values in it
                        $BasicOutput = [PSCustomObject] @{
                                        WiFi_Profile_Name = $ProfileName
                                        Pre_Shared_Key = $PSK
                                        }

                            Write-Host "=============================================================================="
                            Write-Host "Now specify the output location!"
                            Write-Host "`n"
                            Write-Host "=============================================================================="
                            Read-Host "Press [ENTER] to go continue..."
                            Write-Host "`n"

                                function Find-Folders {
                                [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                                [System.Windows.Forms.Application]::EnableVisualStyles()
                                $browse = New-Object System.Windows.Forms.FolderBrowserDialog
                                $browse.SelectedPath = "C:\"
                                $browse.ShowNewFolderButton = $false
                                $browse.Description = "Select a directory"
                                    $loop = $true
                                    while($loop)
                                    {
                                    if ($browse.ShowDialog() -eq "OK")
                                        {
                                        $loop = $false
		
		                                #Insert your script here
		
                                        } else
                                            {
                                            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
                                            if($res -eq "Cancel")
                                                {
                                                   #Ends script
                                                    return
                                                        }
                                                     }
                                                 }
                                    $browse.SelectedPath
                                    $browse.Dispose()
                                    }  
                            $DIR = Find-Folders

                            ## Exports the SSID settings
                            netsh wlan export profile $SSID folder=$DIR key=clear
                                                        
                            Write-Host "`n"
                            Write-Host "The SSID you specified is: $ProfileName" -ForegroundColor Green
                            Write-Host "The Output is saved in:- $Dir" -ForegroundColor Green
                            Write-Host "`n"
                            Write-Host "=============================================================================="
                            Read-Host "Press [ENTER] to go back to the main menu..."
                            Write-Host "`n"





           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')

# =============================================================================
# END OF CODE
# =============================================================================

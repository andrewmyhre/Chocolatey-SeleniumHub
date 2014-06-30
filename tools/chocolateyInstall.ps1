#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'SeleniumGridInABox.Hub' # arbitrary name for the package, used in messages
$installerType = 'EXE_MSI_OR_MSU' #only one of these: exe, msi, msu
$url = 'http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar' # download url
$silentArgs = 'SILENT_ARGS_HERE' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyZipPackage "TanukiWrapper" "http://wrapper.tanukisoftware.com/download/3.5.25/wrapper-windows-x86-32-3.5.25.zip" "c:\SeleniumHub" "$null"
Copy-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\wrapper.conf" "C:\SeleniumHub\wrapper-windows-x86-32-3.5.25\conf\wrapper.conf"
Get-ChocolateyWebFile "SeleniumServerStandalone" "c:\SeleniumHub\wrapper-windows-x86-32-3.5.25\lib\selenium-server-standalone-latest.jar" "http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar"
iex "c:\SeleniumHub\wrapper-windows-x86-32-3.5.25\bin\InstallTestWrapper-NT.bat"
iex "c:\SeleniumHub\wrapper-windows-x86-32-3.5.25\bin\StartTestWrapper-NT.bat"

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights
# if removing $url64, please remove from here
#Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
# download and unpack a zip file
# if removing $url64, please remove from here
#Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" "$url64"

#try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  # other helpers - using any of these means you want to uncomment the error handling up top and at bottom.
  # downloader that the main helpers use to download items
  # if removing $url64, please remove from here
  #Get-ChocolateyWebFile "$packageName" 'DOWNLOAD_TO_FILE_FULL_PATH' "$url" "$url64"
  # installer, will assert administrative rights - used by Install-ChocolateyPackage
  #Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" '_FULLFILEPATH_' -validExitCodes $validExitCodes
  # unzips a file to the specified location - auto overwrites existing content
  #Get-ChocolateyUnzip "FULL_LOCATION_TO_ZIP.zip" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  # Runs processes asserting UAC, will assert administrative rights - used by Install-ChocolateyInstallPackage
  #Start-ChocolateyProcessAsAdmin 'STATEMENTS_TO_RUN' 'Optional_Application_If_Not_PowerShell' -validExitCodes $validExitCodes
  # add specific folders to the path - any executables found in the chocolatey package folder will already be on the path. This is used in addition to that or for cases when a native installer doesn't add things to the path.
  #Install-ChocolateyPath 'LOCATION_TO_ADD_TO_PATH' 'User_OR_Machine' # Machine will assert administrative rights
  # add specific files as shortcuts to the desktop
  #$target = Join-Path $MyInvocation.MyCommand.Definition "$($packageName).exe"
  #Install-ChocolateyDesktopLink $target

  #------- ADDITIONAL SETUP -------#
  # make sure to uncomment the error handling if you have additional setup to do

  #$processor = Get-WmiObject Win32_Processor
  #$is64bit = $processor.AddressWidth -eq 64


  # the following is all part of error handling
  #Write-ChocolateySuccess "$packageName"
#} catch {
  #Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  #throw
#}
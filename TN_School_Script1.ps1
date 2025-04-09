$username = Read-Host "Enter the device username"

Set-Content -Path "$env:TEMP\username.txt" -Value $username

$password = Read-Host "Enter the device password"

Set-Content -Path "$env:TEMP\password.txt" -Value $password

$code = Read-Host "Enter the verification code"

Set-Content -Path "$env:TEMP\code.txt" -Value $code

#############check storage########################

$available_storage = Get-WmiObject -Class win32_logicaldisk | Where-Object { $_.DeviceID -eq "C:" } | Select-Object -ExpandProperty FreeSpace | ForEach-Object { [math]::Round($_/1GB,2) }

if($available_storage -lt 50){

    Write-Output "Not enough Storage"

}

else{

    Write-Output "Proceeding ahead"
 
 
###################check installed browser##########################

$browser_check = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\App Paths\*" | Where-Object { $_.PSChildName -match "chrome|firefox|msedge|opera|brave" } | Select-Object PSChildName).PSChildName

if($browser_check -notcontains 'chrome.exe'){

$chromeInstallerUrl = "https://dl.google.com/chrome/install/375.126/chrome_installer.exe"

$installerPath = "$env:TEMP\chrome_installer.exe"
 
################### Download Chrome installer##########################

Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $installerPath

Start-Sleep -Seconds 10

# Install Chrome silently

Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait

Remove-Item -Path $installerPath -Force

$install_verify = Get-Item "C:\Program Files\Google\Chrome\Application\chrome.exe"

if(!$install_verify){

Write-Output "Something went wrong!!!Contact Soumya A Pattar - soumya.a@arche.global"

}

}
 
############check installed drivers

$driverPaths = @(

    "C:\Program Files\Microsoft\Edge\Application\msedgedriver.exe",

    "C:\Program Files (x86)\Microsoft\Edge\Application\msedgedriver.exe"

)
 
$installedDrivers = @()
 
foreach ($path in $driverPaths) {

    if (Test-Path $path) {

        $installedDrivers += ($path -split '\\')[-1] # Extracts driver name

    }

}
 
if ($installedDrivers.Count -eq 0) {

    Write-Output "No browser drivers found."

    ###########################################

   #Fetch the browser version

$edge_browser_version = (Get-Command "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe").FileVersionInfo.ProductVersion
 
 
$edgeDriverUrl = "https://msedgedriver.azureedge.net/$edge_browser_version/edgedriver_win64.zip"

$downloadPath = "$env:TEMP\edgedriver.zip"

$extractPath = "C:\Program Files\Microsoft\Edge\Application"
 
# Download Edge WebDriver ZIP

Invoke-WebRequest -Uri $edgeDriverUrl -OutFile $downloadPath
 
# Extract Edge WebDriver

Expand-Archive -Path $downloadPath -DestinationPath $extractPath -Force
 
# Remove ZIP file after extraction

Remove-Item -Path $downloadPath -Force
 
Write-Output "Edge WebDriver version $latestVersion installed successfully."

    ###########################################

} else {

    Write-Output "Installed Browser Drivers: $($installedDrivers -join ', ')"

}
 
 
#################check python is installed or not###################

$check_py_install = python --version

if(!$check_py_install){

$pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.1/python-3.12.1-amd64.exe"

$installerPath = "$env:TEMP\python_installer.exe"
 
####################Download Python installe######################r

Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerPath

Start-Sleep -Seconds 10

# Install Python silently

Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
 
# Verify installation

$check_py_install_2 = python --version

if(!$check_py_install){

Write-Output "Unable to install Python. Please check if all the pre-requisites are full filled!"

}

}

}
 
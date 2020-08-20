$downloadUri = "https://cloudbase.it/downloads/CloudbaseInitSetup_x64.msi"
$installerPath = "C:\Windows\Temp\cloudbaseinit.msi"
$installLog = "C:\Users\administrator\Desktop\install_cloudbase-init.log"

function Get-Installer {
  $progressPreference = "silentlyContinue"
  Invoke-WebRequest -OutFile $installerPath $downloadUri
}

function Install-Cloudbase {
  $p = Start-Process -PassThru -FilePath msiexec -ArgumentList "/i $installerPath /qn /l*v $installLog /norestart REBOOT=ReallySuppress"
  Wait-Process -Id $p.id -Timeout 240
  if (($p.ExitCode -ne 0) -and ($p.ExitCode -ne 3010)) {
    $p.ExitCode
    Write-Error "ERROR: problem encountered during cloudbase-init install"
  }
}

Write-Host "BEGIN: install_cloudbase_init.ps1"
Write-Host "Downloading Cloudbase-init from $downloadUri"
Get-Installer
Write-Host "Installing Cloudbase-init"
Install-Cloudbase
Write-Host "END: install_cloudbase_init.ps1"

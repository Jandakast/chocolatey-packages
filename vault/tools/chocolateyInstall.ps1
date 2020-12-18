$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/vault/1.6.1/vault_1.6.1_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/vault/1.6.1/vault_1.6.1_windows_amd64.zip'
$checksum = '1d21d2195b4a1b2cae9d34b51fa4d04803337a7dce0395dae550fb2a05f10a48'
$checksum64 = '4a9b0c803098e745f22bdd510205803ceb4c800fb9c89810c784b6a9e9abc4a4'

$unzipLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition

if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\vault")) {
  if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\vault\tools")) {
    # clean old plugins and ignore files
    Write-Host "Removing old vault plugins"
    Remove-Item "$env:ChocolateyInstall\lib\vault\tools\vault-*.*"
  }
}
else {
  if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\vault")) {
    if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\vault\tools")) {
      # clean old plugins and ignore files
      Write-Host "Removing old vault plugins"
      Remove-Item "$env:ALLUSERSPROFILE\chocolatey\lib\vault\tools" -Include "vault-*.*"
    }
  }
}

$packageParams = @{
  PackageName   = "vault"
  UnzipLocation = $unzipLocation
  Url           = $url
  Url64         = $url64
  Checksum      = $checksum
  Checksum64    = $checksum64
  ChecksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageParams

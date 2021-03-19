$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/vault/1.6.3/vault_1.6.3_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/vault/1.6.3/vault_1.6.3_windows_amd64.zip'
$checksum = '66276480530e3b4cd71e9f5a184f3565a07127ffa4398d569b7d6a920de4c99d'
$checksum64 = '8ce2ef4d8cf89beeb391ad474beba021fe3b1bb70b51d24d095ed1e1088312d7'

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

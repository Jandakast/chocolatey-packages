$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/vault/1.6.0/vault_1.6.0_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/vault/1.6.0/vault_1.6.0_windows_amd64.zip'
$checksum = '59779ef2bcb9988d853a4b5a64c18e9beffb297114f3509a9878d605739b84f5'
$checksum64 = 'f4df525126885663a622478de34a9e6970985e29875b86cbb5a72860b7ab1a3f'

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

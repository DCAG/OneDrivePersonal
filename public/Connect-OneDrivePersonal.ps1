<#
.SYNOPSIS
Function to connect to OneDrive Personal

.DESCRIPTION
Long description

.EXAMPLE
Connect-OneDrivePersonal

.NOTES
General notes
#>
function Connect-OneDrivePersonal {
  [CmdletBinding()]
  param()

  try {
      Connect-MgGraph -Scopes "Files.ReadWrite.All" -UseDeviceAuthentication
      $drive = Get-MgDrive | Where-Object { $_.DriveType -eq 'personal' }
      if (-not $drive) {
          throw "No personal OneDrive found."
      }
      $Global:OneDrivePersonalId = $drive.Id
      Write-Host "Connected to OneDrive Personal successfully. Drive ID: $($Global:OneDrivePersonalId)"
  }
  catch {
      Write-Error "Failed to connect to OneDrive Personal: $_"
  }
}
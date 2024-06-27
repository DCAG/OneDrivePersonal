
<#
.SYNOPSIS
Function to get a file or folder

.DESCRIPTION
Long description

.PARAMETER Id
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>
function Get-OneDrivePersonalItem {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [string]$Id
  )

  process {
      try {
          if (-not $Global:OneDrivePersonalId) {
              throw "Not connected to OneDrive Personal. Please run Connect-OneDrivePersonal first."
          }
          if ([string]::IsNullOrWhiteSpace($Id)) {
              $item = Get-MgDriveRoot -DriveId $Global:OneDrivePersonalId -ErrorAction Stop
          }
          else {
              $item = Get-MgDriveItem -DriveId $Global:OneDrivePersonalId -DriveItemId $Id -ErrorAction Stop
          }
          return $item
      }
      catch {
          Write-Error "Failed to get item at path '$Id': $_"
      }
  }
}
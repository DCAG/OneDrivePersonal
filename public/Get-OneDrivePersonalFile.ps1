

# Function to download a file
function Get-OneDrivePersonalFile {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [string]$Id,
      [Parameter(Mandatory = $true)]
      [string]$LocalFilePath
  )

  process {
      try {
          if (-not $Global:OneDrivePersonalId) {
              throw "Not connected to OneDrive Personal. Please run Connect-OneDrivePersonal first."
          }
          Get-MgDriveItemContent -DriveId $Global:OneDrivePersonalId -DriveItemId $Id -OutFile $LocalFilePath -ErrorAction Stop
          Write-Host "File downloaded successfully from '$Path' to '$LocalFilePath'."
      }
      catch {
          Write-Error "Failed to download file from '$Id' to '$LocalFilePath'"
      }
  }
}

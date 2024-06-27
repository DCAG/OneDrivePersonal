

# Function to upload a file
function Add-OneDrivePersonalFile {
  [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
  param(
      [Parameter(Mandatory = $true)]
      [string]$Path,
      [Parameter(Mandatory = $true)]
      [string]$LocalFilePath
  )

  if ($PSCmdlet.ShouldProcess("Upload file '$LocalFilePath' to '$Path'")) {
      try {
          if (-not $Global:OneDrivePersonalId) {
              throw "Not connected to OneDrive Personal. Please run Connect-OneDrivePersonal first."
          }
          $file = New-MgDriveItemContent -DriveId $Global:OneDrivePersonalId -DriveItemPath $Path -InFile $LocalFilePath -ErrorAction Stop
          Write-Host "File '$LocalFilePath' uploaded successfully to '$Path'."
          return $file
      }
      catch {
          Write-Error "Failed to upload file '$LocalFilePath' to '$Path': $_"
      }
  }
}
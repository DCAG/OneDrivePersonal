

# Function to update file metadata
function Update-OneDrivePersonalItemMetadata {
  [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
  param(
      [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [string]$Path,
      [Parameter(Mandatory = $true)]
      [hashtable]$Metadata
  )

  process {
      if ($PSCmdlet.ShouldProcess("Update metadata for item at '$Path'")) {
          try {
              if (-not $Global:OneDrivePersonalId) {
                  throw "Not connected to OneDrive Personal. Please run Connect-OneDrivePersonal first."
              }
              $updatedItem = Update-MgDriveItem -DriveId $Global:OneDrivePersonalId -DriveItemPath $Path -BodyParameter $Metadata -ErrorAction Stop
              Write-Host "Metadata updated successfully for item at '$Path'."
              return $updatedItem
          }
          catch {
              Write-Error "Failed to update metadata for item at '$Path': $_"
          }
      }
  }
}
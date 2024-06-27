

# Function to create a new folder
function New-OneDrivePersonalFolder {
  [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
  param(
      [Parameter(Mandatory = $true)]
      [string]$Path,
      [Parameter(Mandatory = $true)]
      [string]$FolderName
  )

  if ($PSCmdlet.ShouldProcess("Create folder '$FolderName' at '$Path'")) {
      try {
          if (-not $Global:OneDrivePersonalId) {
              throw "Not connected to OneDrive Personal. Please run Connect-OneDrivePersonal first."
          }
          $params = @{
              "@microsoft.graph.conflictBehavior" = "fail"
              Name                                = $FolderName
              Folder                              = @{}
          }
          #TODO: How to select location???
          $newFolder = New-MgDriveItem -DriveId $Global:OneDrivePersonalId -BodyParameter $params -ErrorAction Stop
          Write-Host "Folder '$FolderName' created successfully at '$Path'."
          return $newFolder
      }
      catch {
          Write-Error "Failed to create folder '$FolderName' at '$Path': $_"
      }
  }
}
# Function to list all files and folders in a specified path
function Get-OneDrivePersonalChildItem {
  [CmdletBinding()]
  param(
      [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [string]$Path = "/",

      [switch]$Recurse,

      [ValidateSet("All", "File", "Folder")]
      [string]$ItemType = "All"
  )

  begin {
      if (-not $Global:OneDrivePersonalId) {
          throw "Not connected to OneDrive Personal. Please run Connect-OneDrivePersonal first."
      }
  }

  process {
      try {
          # Call the function to get items
          Get-ItemsAtPath @PSBoundParameters
      }
      catch {
          Write-Error "Failed to get items at path '$Path': $_"
      }
  }
}
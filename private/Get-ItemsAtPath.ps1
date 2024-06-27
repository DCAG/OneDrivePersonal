# Function to get items at a specific path
function Get-ItemsAtPath {
  [CmdletBinding()]
  param (
    [string]$Path = '',
    [ValidateSet("All", "File", "Folder")]
    [string]$ItemType = "All",
    [switch]$Recurse,
    [string]$ParentId,
    [int]$RecurseDepth = 1,
    [switch]$RecurseNoLimit
  )

  $fullPath = $Path.TrimStart('/')

  if ($fullPath -eq '') {
    $root = Get-MgDriveRoot -DriveId $Global:OneDrivePersonalId
    $items = Get-MgDriveItemChild -DriveId $Global:OneDrivePersonalId -DriveItemId $root.Id
  }
  else {
    $items = Get-MgDriveItemChild -DriveId $Global:OneDrivePersonalId -DriveItemId $ParentId
  }

  foreach ($item in $items) {
    $itemFullPath = $fullPath + '/' + $item.Name
    
    if (($ItemType -eq "All") -or
        ($ItemType -eq "File" -and -not $item.Folder) -or
        ($ItemType -eq "Folder" -and $item.Folder)) {
        
      $item | Add-Member -NotePropertyName "FullPath" -NotePropertyValue $itemFullPath -PassThru -Force
    }

    if ($Recurse -and $item.Folder -and ($RecurseDepth -gt 0 -or $RecurseNoLimit)) {
      Get-ItemsAtPath -Path $itemFullPath -ParentId $item.Id -Recurse:$Recurse -RecurseDepth ($RecurseDepth - 1) -RecurseNoLimit:$RecurseNoLimit
    }
  }
}


# Get-ItemsAtPath -Recurse -RecurseNoLimit -ov +allmyfiles


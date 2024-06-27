
function Get-OneDriveChildItemByPathInnerStep {
  [Alias('Walk-OneDriveChildItem')]
  [CmdletBinding()]
  param(
    [object]$Item,
    [string]$Fragment,
    [array]$remainingFragments
  )

  $items = Get-MgDriveItemChild -DriveId $Global:OneDrivePersonalId -DriveItemId $item.Id
  if($Fragment -eq '/'){
    $items
    return
  }

  $item = $items | Where-Object Name -eq $Fragment
  '[{0}] Current Item: {1}, RemainingFragments: {2}' -f $PSCmdlet.MyInvocation.MyCommand.Name, $item.Name, ($remainingFragments -join '/') | Write-Verbose
  $NumOfRemainingFragments = $remainingFragments.length - 1
  if ($null -ne $item -and $NumOfRemainingFragments -ge 0) {
    Get-OneDriveChildItemByPathInnerStep -Item $item -Fragment $remainingFragments[0] -remainingFragments ($NumOfRemainingFragments -gt 0 ? $remainingFragments[1..$NumOfRemainingFragments] : @())
    return
  }
  
  $item
  return
}

function Get-OneDriveChildItemByPath {
  [CmdletBinding()]
  param(
    [string]$Path
  )
  
  $fragments = $Path.TrimStart('/') -split '/'
  if($fragments[-1] -eq ''){
    $fragments[-1] = '/'
  }
  $root = Get-MgDriveRoot -DriveId $Global:OneDrivePersonalId
  Get-OneDriveChildItemByPathInnerStep -item $root -fragment $fragments[0] -remainingFragments $fragments[1..($fragments.length - 1)]
}

#Example
#Get-OneDriveChildItemByPath -Path '/Automation/PowerShell/PowerShell/OneDrive-2015-01-29/DSC/' -Verbose
#Get-OneDriveChildItemByPath -Path '/Automation/PowerShell/PowerShell/OneDrive-2015-01-29/DSC' -Verbose
#Get-OneDriveChildItemByPath -Path '/Automation/PowerShell/PowerShell/OneDrive-2015-01-29/DSC/AkadaDSC.ps1' -Verbose
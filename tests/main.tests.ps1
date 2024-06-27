Describe 'Connect-OneDrivePersonal' {
  BeforeAll {
    # load global variables
    . 'variables/variables.ps1'
    . 'public/Connect-OneDrivePersonal.ps1'
    Connect-OneDrivePersonal
  }
  It 'should be connected' {
    $Global:OneDrivePersonalId | should -Not -BeNullOrEmpty
  }
}
  
Describe 'Get-OneDrivePersonalChildItem' {
  BeforeAll {
    # load global variables
    . 'variables/variables.ps1'
    . 'private/Get-ItemsAtPath.ps1'
    . 'public/Get-OneDrivePersonalItem.ps1'
    . 'public/Get-OneDrivePersonalChildItem.ps1'
    . 'public/Connect-OneDrivePersonal.ps1'
    if (-not $Global:OneDrivePersonalId) {
      Connect-OneDrivePersonal
    }
  }

  It 'should get files in root directory' {
    $files = Get-OneDrivePersonalChildItem -Path '/' -ItemType All
    $files[0].ParentReference.Path | should -BeExactly '/drive/root:'
  }

  It 'should not throw on recursive call' {
    {Get-OneDrivePersonalChildItem -Path '/' -ItemType All -Recurse} | should -Not -Throw
  }
}
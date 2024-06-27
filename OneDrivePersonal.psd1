@{
  # Script module or binary module file associated with this manifest
  RootModule         = 'OneDrivePersonal.psm1'

  # Version number of this module.
  ModuleVersion      = '1.0.0'

  # Supported PSEditions
  CompatiblePSEditions = @('Core', 'Desktop')

  # ID used to uniquely identify this module
  GUID               = '6fe3a6f0-6bbd-4579-973d-3058e8fae61a'

  # Author of this module
  Author             = 'Amir'

  # Company or vendor of this module
  CompanyName        = 'Amir Granot'

  # Description of the functionality provided by this module
  Description        = 'A PowerShell module to interact with Microsoft OneDrive Personal for CRUD operations and updating metadata.'

  # Minimum version of the PowerShell engine required by this module
  PowerShellVersion  = '7.0'

  # Modules that must be imported into the global environment prior to importing this module
  RequiredModules    = @(
    'Microsoft.Graph.Authentication'
    'Microsoft.Graph.Files'
  )

  # Assemblies that must be loaded prior to importing this module
  RequiredAssemblies = @()

  # Functions to export from this module
  FunctionsToExport  = @(
      'Connect-OneDrivePersonal',
      'Get-OneDrivePersonalItem',
      'Get-OneDrivePersonalChildItem',
      'New-OneDrivePersonalFolder',
      'Add-OneDrivePersonalFile',
      'Get-OneDrivePersonalFile',
      'Update-OneDrivePersonalItemMetadata',
      'Remove-OneDrivePersonalItem'
  )

  # Cmdlets to export from this module
  CmdletsToExport    = @()

  # Variables to export from this module
  VariablesToExport  = @()

  # Aliases to export from this module
  AliasesToExport    = @()

  # List of all modules packaged with this module
  NestedModules      = @()

  # Scripts to process in the caller's environment, no dotsourcing by default
  ScriptsToProcess   = @()

  # Type files to be loaded when importing this module
  TypesToProcess     = @()

  # Formats to be loaded when importing this module
  FormatsToProcess   = @()

  # Private data to pass to the module specified in RootModule/ModuleToProcess
  PrivateData        = @{}

  # HelpInfo URI
  HelpInfoURI        = ''

  # Default prefix for exported functions
  DefaultCommandPrefix = ''
}

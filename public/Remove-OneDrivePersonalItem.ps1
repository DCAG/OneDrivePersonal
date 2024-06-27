

# Function to delete a file or folder
function Remove-OneDrivePersonalItem {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$Path
    )

    process {
        $item = Get-OneDriveChildItemByPath -Path $Path
        if ($PSCmdlet.ShouldProcess("Delete item at '$Path'")) {
            try {
                if (-not $Global:OneDrivePersonalId) {
                    throw "Not connected to OneDrive Personal. Please run Connect-OneDrivePersonal first."
                }
                Remove-MgDriveItem -DriveId $Global:OneDrivePersonalId -DriveItemId $item.Id -ErrorAction Stop
                Write-Host "Item at '$Path' deleted successfully."
            }
            catch {
                Write-Error "Failed to delete item at '$Path': $_"
            }
        }
    }
}
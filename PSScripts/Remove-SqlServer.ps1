<#
.SYNOPSIS
Creates an AAD group, adds members and outputs the group's Object Id to be consumed by a later task that 

.DESCRIPTION
Creates an AAD group, adds members and outputs the group's Object Id to be consumed by a later task that.  Typically that task will create a group in Kubernetes that is mapped to the AAD group.

.PARAMETER ResourceGroupName
The name of the resource group

.PARAMETER ServerName
Add theserver nae
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [String]$ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [String]$ServerName
)

$server = Get-AzSqlServer -ServerName $ServerName -ResourceGroupName $ResourceGroupName
if (!$server) {

    Write-Verbose "$($ServerName) not found"
    Write-Output "$($ServerName) not found"

} 
else {
    Write-Verbose "Removing $($ServerName)"
    Write-Output  "Removing $($ServerName)"

    Remove-AzSqlServer -ServerName $ServerName -ResourceGroupName $ResourceGroupName

    Write-Verbose "Removed $($ServerName)"
    Write-Output  "Removed $($ServerName)"
}

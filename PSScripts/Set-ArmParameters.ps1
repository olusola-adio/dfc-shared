[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Environment
)

$ApimExists = $null -ne (Get-AzureRmApiManagement -ResourceGroupName "dwp-$Environment-shared-rg" -Name "dwp-$Environment-shared-apim" -ErrorAction Ignore)
Write-Verbose "Writing value $ApimExists to variable apimExists"
Write-Output "##vso[task.setvariable variable=apimExists]$($ApimExists.ToString().ToLower())"
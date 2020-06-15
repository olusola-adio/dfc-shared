using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$yourUri = "https://hooks.slack.com/services/"

$hook = "T38B60AJ2/B0162TB18KA/PQZZR8t2isxPmcEWuA77hN8a"


$name = $Request.Query.Username
if (-not $name) {
    #Write-Host $Request.Body
    $name = $Request.Body.username
    #Write-Host $name 
    #$resourceName = $Request.Body.data.context.resourceName
    #Write-Host $resourceName
    #$timestamp = $Request.Body.data.context.timestamp
}

$mkdwn = $true

if ($name) {
    $status = [HttpStatusCode]::OK
    $rawcreds = @{
        mkdwn = $mkdwn
        text = $name
        attachments = @(@{
            color= "good"
            text = $Request.Body.text 
            #text= "Resource Name is  *${resourceName}* and timestamp was *${timestamp}*"
        })
    }
    $json = $rawcreds | ConvertTo-Json
    $body = $json
    Invoke-WebRequest -Uri "https://hooks.slack.com/services/${hook}" -Method Post -Body $body
} else {
    $status = [HttpStatusCode]::BadRequest
    $body = "Please pass a name on the query string or in the request body."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})


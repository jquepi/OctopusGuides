param(
    [String] $name
)

# Print the version info
& "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" --version

$exists = & "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" group exists --name $name
if ($exists -eq "true") {
    Write-Host "Resource group $name already exists. Deleting."
    & "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" group delete --name $name --yes
}

& "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" group create --location australiaeast --name $name --tags Lifetime=Permanent OwnerContact=@matthew.casperson
& "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" appservice plan create --name $name --resource-group $name --number-of-workers 1 --sku B1
& "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" webapp create -g $name -p $name -n $name --% --runtime "aspnet|V4.7"
& "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" webapp log config -g $name -n $name --application-logging true --detailed-error-messages true --web-server-logging filesystem
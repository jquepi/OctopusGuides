param(
    [String] $name
)

# Print the version info
& "az" --version

$exists = & "az" group exists --name $name
if ($exists -eq "true") {
    Write-Host "Resource group $name already exists. Deleting."
    & "az" group delete --name $name --yes
}

& "az" group create --location australiaeast --name $name --tags Lifetime=Permanent OwnerContact=@matthew.casperson
& "az" appservice plan create --name $name --resource-group $name --number-of-workers 1 --sku B1
& "az" webapp create -g $name -p $name -n $name --% --runtime "aspnet|V4.7"
& "az" webapp log config -g $name -n $name --application-logging true --detailed-error-messages true --web-server-logging filesystem
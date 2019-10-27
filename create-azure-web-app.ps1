param([String] $name)

$exists = & az group exists --name $name
if ($exists -eq "false") {
    Write-Host "Resource group $name does not exist. Creating..."
    az group create --location australiaeast --name $name --tags Lifetime=Permanent OwnerContact=@matthew.casperson
} else {
    Write-Host "Resource group $name already exists."
}

$plans = & az appservice plan list --resource-group $name | ConvertFrom-Json
if ($plans.Count -eq 0) {
    Write-Host "App service plan $name does not exist. Creating..."
    az appservice plan create --name $name --resource-group $name --number-of-workers 1 --sku B1

}
else {
    Write-Host "Resource group $name already exists."
}

$apps = az webapp list --resource-group $name | ConvertFrom-Json
if ($apps.Count -eq 0) {
    Write-Host "Webapp $name does not exist. Creating..."
    az webapp create -g $name -p $name -n $name --% --runtime "aspnet|V4.7"
    az webapp log config -g $name -n $name --application-logging true --detailed-error-messages true --web-server-logging filesystem
} else {
    Write-Host "Webapp $name already exists."
}
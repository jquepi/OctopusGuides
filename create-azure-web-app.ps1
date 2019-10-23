param([String] $name)

$exists = & az group exists --name $name
if ($exists -eq "false") {
    az group create --location australiaeast --name $name --tags Lifetime=Permanent OwnerContact=@matthew.casperson
}

$plans = & az appservice plan list --resource-group $name | ConvertFrom-Json
if ($plans.Count -eq 0) {
    az appservice plan create --name $name --resource-group $name --number-of-workers 1 --sku F1
}

$apps = az webapp list --resource-group $name | ConvertFrom-Json
if ($apps.Count -eq 0) {
az webapp create -g $name -p $name -n $name --% --runtime "aspnet|V4.7"
    az webapp log config -g $name -n $name --application-logging true --detailed-error-messages true --web-server-logging filesystem
}
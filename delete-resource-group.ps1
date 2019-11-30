param([String] $name, [switch] $Wait = $false)
$exists = & az group exists --name $name
if ($exists -eq "true") {
    if ($Wait)
    {
        az group delete --name $name --yes
    }
    else {
        az group delete --name $name --yes --no-wait
    }
}
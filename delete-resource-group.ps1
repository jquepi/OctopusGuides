param([String] $name)
$exists = & az group exists --name $name
if ($exists -eq "true") {
    az group delete --name $name --yes --no-wait
}
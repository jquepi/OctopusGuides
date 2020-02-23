@user { 'vagrant':
  groups     => ['microk8s'],
  membership => minimum,
}

User <| title == vagrant |>
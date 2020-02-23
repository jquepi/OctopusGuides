@user { 'vagrant':
  groups     => ['docker'],
  membership => minimum,
}

User <| title == vagrant |>
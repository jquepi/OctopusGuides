@user { 'jenkins':
  groups     => ['docker'],
  membership => minimum,
}

User <| title == jenkins |>
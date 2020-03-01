file { '/usr/share/applications/Octopus.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Octopus Deploy
    Comment=Username: admin Password: Password01!
    Exec=firefox http://localhost
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=/usr/share/icons/octopus.svg
    Categories=Internet
    | EOL
}

file { '/usr/share/applications/Guides.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Octopus Guides
    Exec=firefox https://octopus.com/docs/guides
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=/usr/share/icons/book.svg
    Categories=Internet
    | EOL
}

file {'/usr/share/icons/octopus.svg':
  content => @("EOL"/L)
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 140 140"><defs><style>.cls-1{fill:#2f93e0;}</style></defs><path class="cls-1" d="M19.13 102.13c9.35-6 20.33-16.34 16.16-28.5C33 67 29.87 61.33 29.45 54.17a43.84 43.84 0 0 1 2.66-17.83C40.49 13.85 65.4 3.2 87.92 10c20.85 6.26 35.2 30.48 26.56 51.58-5 12.18-7.22 21.58 3.9 31.05 3 2.57 10.33 6.42 10.31 11 0 6-11.74-1.27-13-2.31 1.49 2.6 16.24 18 6.85 19.08-8.64 1-16.27-11.06-21.47-16.25-8.72-8.7-7.21 10.55-7.25 14.53-.06 6.28-4.5 19-12.46 10.72-6.58-6.84-4.09-17.76-8.66-25.36-5-8.33-13.34 8.33-15.42 11.37-2.33 3.4-14 19.89-18.59 11.1-3.76-7.13 2.25-18.3 5.2-24.75-1.08 2.34-8.71 5.8-10.94 6.93-5 2.54-10.15 4.05-15.82 3.65-11.73-.84-2.73-7.07 2-10.15z" id="Logos"/></svg>
  | EOL
}

file {'/usr/share/icons/book.svg':
  content => @("EOL"/L)
    <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
<path style="fill:#1B4145;" d="M512,429.932v34.133c-42.928,0-101.831-38.286-164.068-38.286c-36.671,0-59.654,15.132-73.466,30.254
	H256l-22.756-106.018L512,429.932z"/>
<path style="fill:#609399;" d="M256,350.015v106.018h-18.466c-13.813-15.121-36.796-30.254-73.466-30.254
	c-62.236,0-121.139,38.286-164.068,38.286v-34.133L256,350.015z"/>
<path style="fill:#6FC5D6;" d="M512,86.221v343.711c-42.928,0-101.831-38.286-164.068-38.286c-36.671,0-59.654,15.132-73.466,30.254
	H256l-45.511-156.723L256,108.453c0,0,18.591-60.518,91.932-60.518C410.169,47.935,469.072,86.221,512,86.221z"/>
<path style="fill:#B4E5EA;" d="M256,108.453v313.446h-18.466c-13.813-15.132-36.796-30.254-73.466-30.254
	c-62.236,0-121.139,38.286-164.068,38.286V86.221c42.928,0,101.831-38.286,164.068-38.286C237.409,47.935,256,108.453,256,108.453z"
	/>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
<g>
</g>
</svg>
  | EOL
}
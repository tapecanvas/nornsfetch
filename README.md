# nornsfetch
> neofetch style system info for norns

![screenshot showing ascii art norns and system info displayed on norns screen](norns.png)
![screenshot showing ascii art norns shield and system info displayed on norns screen](shield.png)

## features
- user and hostname
- ip address
- uptime
- number of linux packages
- number of scripts installed
- screen resolution
- norns release version
- cute ascii norns (:
  - e2 switches between norns and shield ascii art

## install
in maiden, enter `;install https://github.com/tapecanvas/nornsfetch`

## todo
- [x] add disk info (free/total) entry
- [ ] add to and format "no-ascii" option

### archive
- [x] add no-ascii option - display more sys info (longer lines / more verbose, or 2 col readout w/ more entries) 
- [x] [detect factory norns or shield](https://monome.org/docs/norns/api/modules/norns.html) and display appropriate ascii norns
  - instead, I added shield ascii and e2 switches between - your choice 

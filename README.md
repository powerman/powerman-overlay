# My overlay for Gentoo Linux

Most notable packages:

- Runit:
  - `sys-process/runit`: only difference from portage package is removed
    default files from `/etc/runit/` (they're in
    `power-misc/runit-scripts`)
  - `runit-service/service-*`: `./run` files for many services (agetty,
    apache, mysql, …)
  - `power-misc/runit-scripts`: boot scripts (replacement for
    sysvinit/baselayout/openrc boot scripts)
- OS Inferno:
  - `dev-inferno/inferno`
- My software:
  - `power-misc/addgpginfo`
  - `power-misc/deliver`
  - `power-misc/greysmtpd`
  - `power-misc/powerbackup`
  - `power-misc/powerutils`
  - `power-misc/powerwatchdog`
  - `power-misc/remote`
- Other:
  - `mail-mta/netqmail`: only difference from portage is added outgoingips
    patch
  - `media-sound/cue2tracks`
  - `media-sound/flaccl`
  - `net-ftp/twoftpd`: with patch to support Russian file names in Windows
    CP1251 encoding
  - `net-im/skype4pidgin`
  - `net-p2p/i2p`: usually newer version than available in portage
  - `net-p2p/rtorrent`: only difference from portage is added colors patch

# Install

Install layman if you doesn't have it yet:

```
# emerge layman
```

Next fetch list of available overlays and add my overlay:

```
# layman -L
# layman -a powerman
```


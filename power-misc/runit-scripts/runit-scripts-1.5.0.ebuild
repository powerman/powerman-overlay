# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit linux-info

DESCRIPTION="Replacement for SysV init scripts to use with runit."
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">sys-process/runit-1.8.0"
RDEPEND="
	sys-process/runit
	runit-service/service-log-all
	>=virtual/udev-197
	sys-apps/sysvinit
	sys-apps/busybox
	net-firewall/iptables
	sys-apps/iproute2
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	if [ "$(readlink -f /var/service/log-all)" != "/service/log-all" ]; then
		ewarn "You MUST run service 'log-all' at ALL runlevels!"
		ewarn "Please run:	ln -nsf /service/log-all /var/service/log-all"
	fi
	if ! linux_config_exists || ! linux_chkconfig_present DEVTMPFS; then
		ewarn "Please enable CONFIG_DEVTMPFS in your kernel config."
	fi
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info

DESCRIPTION="Replacement for SysV init scripts to use with runit."
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=sys-process/runit-2.1.2-r1"
RDEPEND="net-firewall/iptables
	runit-service/service-log-all
	sys-apps/busybox
	sys-apps/iproute2
	sys-apps/sysvinit
	sys-process/runit
	virtual/udev"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	if [ ! -d "${ROOT}"etc/runit/runsvdir/single ] ||
		[ "$(find "${ROOT}"etc/runit/runsvdir/single/ -type l)" = "" ]; then
		ewarn "If you are using 'runsvchdir single' in /etc/runit/1,"
		ewarn "then you should create ${ROOT}etc/runit/runsvdir/single/"
		ewarn "with at least only getty service in it."
	fi
	if [ ! -d "${ROOT}${SVDIR}"/log-all ]; then
		ewarn "You MUST run service 'log-all' at ALL runlevels!"
		ewarn "Please run:	ln -s /etc/sv/log-all ${ROOT%/}${SVDIR%/}/"
	fi
	if ! linux_config_exists || ! linux_chkconfig_present DEVTMPFS; then
		ewarn "Please enable CONFIG_DEVTMPFS in your kernel config."
	fi
}

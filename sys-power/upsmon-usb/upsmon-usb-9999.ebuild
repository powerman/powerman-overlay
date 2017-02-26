# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit java-pkg-2 linux-info

DESCRIPTION="Powercom UPS monitoring (USB)"
HOMEPAGE="http://www.pcm.ru/support/download/soft/"
SRC_URI="http://www.pcm.ru/data/download/public/soft/upsmon_for_linux.rar"

SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND="app-arch/rar"

S="${WORKDIR}"

CONFIG_CHECK="~USB_HIDDEV"
ERROR_USB_HIDDEV="
You need to turn on the '/dev/hiddev raw HID device support'
option under 'HID Devices' in order to use upsmon-usb
"

pkg_setup() {
	linux-info_pkg_setup
	java-pkg-2_pkg_setup
}

src_prepare() {
	tar xf UPSMON_USB_for_Linux.tar
}

src_install() {
	java-pkg_sointo /usr/$(get_libdir)
	java-pkg_doso Components/*.so
	java-pkg_dojar Components/*.jar
	dohtml -r ReadMe_*
	dodir /opt
	mv "${S}/UPSMON_USB_for_Linux" "${D}/opt/${PN}" || die
	java-pkg_addcp "/opt/${PN}"
	java-pkg_addcp "/opt/${PN}/EXT"
	java-pkg_dolauncher upsmon_service --main UPSMON --pwd "/opt/${PN}"
	java-pkg_dolauncher upsmon_display --main Display --pwd "/opt/${PN}/EXT"

	doenvd "${FILESDIR}/20${PN}"
}

pkg_postinst() {
	if [ $(ls /proc/bus/usb/ | wc -l) == 0 ]; then
		ewarn "UPSMON require /proc/bus/usb/ which can be provided in two ways:"
		ewarn "a)  Using udev."
		ewarn "    Add this to /etc/fstab and run 'mount /proc/bus/usb':"
		ewarn "      /dev/bus/usb  /proc/bus/usb  none  bind  0 0"
		ewarn "b)  Using usbfs (DEPRECATED)."
		ewarn "    Make sure CONFIG_USB_DEVICEFS enabled in kernel."
		ewarn "    Add this to /etc/fstab and run 'mount /proc/bus/usb':"
		ewarn "      none  /proc/bus/usb  usbfs  defaults  0 0"
	fi
}

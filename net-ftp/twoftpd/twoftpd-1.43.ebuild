# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Simple secure efficient FTP server by Bruce Guenter"
HOMEPAGE="http://untroubled.org/twoftpd/"
SRC_URI="http://untroubled.org/twoftpd/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/libc
		>=dev-libs/bglibs-1.103
		>=net-libs/cvm-0.90"
RDEPEND="sys-apps/ucspi-tcp
		sys-process/daemontools
		>=net-libs/cvm-0.90"

DOCS=(ANNOUNCEMENT ChangeLog NEWS README TODO VERSION twoftpd.run twoftpd-log.run)

src_prepare() {
	eapply "$FILESDIR"/FF.patch
	default
}

src_configure() {
	echo "/usr/sbin" >conf-bin || die
	echo "/usr/share/man" >conf-man || die
	echo "$(tc-getCC) ${CFLAGS} -I/usr/include/bglibs" >conf-cc || die
	echo "$(tc-getCC) -s -L/usr/lib/bglibs" >conf-ld || die
}

src_install() {
	emake install install_prefix="$D"
	einstalldocs
}

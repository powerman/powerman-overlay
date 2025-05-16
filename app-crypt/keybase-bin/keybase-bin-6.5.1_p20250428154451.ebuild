# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg-utils

DESCRIPTION="Client for keybase.io (binary version with GUI)"
HOMEPAGE="https://keybase.io/"

MY_PN="${PN/-bin/}"
COMMIT_ID=19f9cfeddb
MY_PV="$(ver_cut 1-3)-$(ver_cut 4 ${PV/p//}).${COMMIT_ID}"
SRC_URI="https://prerelease.keybase.io/linux_binaries/deb/${MY_PN}_${MY_PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="strip"

RDEPEND="
	app-crypt/gnupg
	!app-crypt/kbfs
	!app-crypt/keybase
"

QA_PREBUILT="
	opt/keybase/libEGL.so
	opt/keybase/libGLESv2.so
	opt/keybase/libffmpeg.so
	opt/keybase/Keybase
	usr/bin/git-remote-keybase
	usr/bin/kbfsfuse
	usr/bin/kbnm
	usr/bin/keybase
	usr/bin/keybase-redirector
"

src_prepare() {
	default
	rm etc/cron.daily/keybase # apt repo re-enabler
	mv opt/keybase/post_install.sh{,.example}
	mv usr/share/doc/keybase doc
	gzip -d doc/changelog.Debian.gz
}

src_install() {
	insinto /
	doins -r etc/
	doins -r opt/
	doins -r usr/
	dodoc doc/*
	exeinto /opt/keybase
	doexe opt/keybase/*.so
	doexe opt/keybase/Keybase
	doexe opt/keybase/chrome-sandbox
	exeinto /usr/bin
	doexe usr/bin/*
	fperms +s /usr/bin/keybase-redirector
	fperms 4755 /opt/keybase/chrome-sandbox
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	mkdir -p /keybase

	elog "Start/Restart keybase: run_keybase"
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	rmdir /keybase 2>/dev/null || :
}

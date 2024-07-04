# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd desktop

DESCRIPTION="RustDesk Client"
HOMEPAGE="https://rustdesk.com/"
SRC_URI="https://github.com/rustdesk/rustdesk/releases/download/${PV}/rustdesk-${PV}-x86_64.deb -> ${P}.deb"

S=${WORKDIR}

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-accessibility/at-spi2-core
	app-arch/bzip2
	app-arch/lz4
	app-arch/xz-utils
	app-arch/zstd
	app-crypt/argon2
	app-crypt/libmd
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/json-c
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libpcre
	dev-libs/openssl
	dev-libs/wayland
	media-gfx/graphite2
	media-libs/flac
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	media-libs/libglvnd
	media-libs/libjpeg-turbo
	media-libs/libogg
	media-libs/libpng
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/opus
	media-sound/lame
	media-sound/mpg123
	net-libs/libasyncns
	sys-apps/dbus
	sys-apps/util-linux
	sys-devel/gcc
	sys-fs/cryptsetup
	sys-fs/lvm2
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman
	x11-misc/xdotool"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${P}".deb || die "Cannot unpack!"
	unpack "${WORKDIR}"/data.tar.xz
}

src_prepare() {
	default
	# Add Categories to Desktop-File
	sed -i -e '/Type=Application/aCategories=Network;GTK;' \
		usr/share/applications/rustdesk.desktop || die "sed failed!"
	# Fix Path in Systemd-Unit
	sed -i -e 's|/var/run/rustdesk.pid|/run/rustdesk.pid|' \
		usr/share/rustdesk/files/systemd/rustdesk.service || die "sed failed!"
}

src_install() {
	# Install Binary
	exeinto /usr/lib/rustdesk
	doexe usr/lib/rustdesk/rustdesk
	dosym ../lib/rustdesk/rustdesk /usr/bin/rustdesk
	# Install Library
	exeinto /usr/lib/rustdesk/lib
	doexe usr/lib/rustdesk/lib/*
	insinto /usr/lib/rustdesk
	doins -r usr/lib/rustdesk/data
	# Install Miscellaneous
	domenu usr/share/applications/rustdesk.desktop
	insinto /usr/share/icons/hicolor/256x256/apps
	doins usr/share/icons/hicolor/256x256/apps/rustdesk.png
	insinto /usr/share/icons/hicolor/scalable/apps
	doins usr/share/icons/hicolor/scalable/apps/rustdesk.svg
	# Install Systemd-Unit
	systemd_dounit usr/share/rustdesk/files/systemd/rustdesk.service
}

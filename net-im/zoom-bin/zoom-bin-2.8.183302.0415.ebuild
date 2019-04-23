# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils unpacker

DESCRIPTION="Video conferencing and web conferencing service"
HOMEPAGE="https://zoom.us/"
SRC_URI="https://zoom.us/client/${PV}/zoom_x86_64.pkg.tar.xz -> zoom_${PV}_x86_64.pkg.tar.xz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

IUSE="pulseaudio gstreamer"

RESTRICT="mirror"

RDEPEND="
	|| (
		pulseaudio? ( media-sound/pulseaudio )
		gstreamer? ( media-libs/gst-plugins-base )
	)
	dev-db/sqlite
	dev-db/unixODBC
	dev-libs/glib
	dev-libs/libxslt
	dev-libs/nss
	dev-qt/qtmultimedia
	dev-qt/qtsvg
	dev-qt/qtwebengine
	media-libs/fontconfig
	media-libs/mesa
	x11-libs/libXcomposite
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libxcb
"
DEPEND=""
BDEPEND=""

QA_PREBUILT="
	opt/zoom/*.so
	opt/zoom/*.so.*
	opt/zoom/zoom
	opt/zoom/qtdiag
	opt/zoom/QtWebEngineProcess
"

S="${WORKDIR}"

src_install() {
	sed -i -e '/^Icon=/s/\..*//' usr/share/applications/Zoom.desktop || die
	sed -i -e '/^Categories=/s/Application;//' usr/share/applications/Zoom.desktop || die
	rmdir usr/share/doc/zoom || die
	mv "${S}/"* "${ED}" || die
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

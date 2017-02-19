# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 mono

DESCRIPTION="WebDAV emulator for Mail.ru Cloud"
HOMEPAGE="https://github.com/yar229/WebDavMailRuCloud"
EGIT_REPO_URI="https://github.com/yar229/WebDavMailRuCloud"
EGIT_COMMIT="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-lang/mono-4.6.2.16
	dev-dotnet/nuget
	"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	nuget restore WebDAVMailRuCloud.sln
}

src_compile() {
	xbuild /property:Configuration=Release || die

	mv WDMRC.Console/bin/Release/{nwebdav.server.dll,NWebDav.Server.dll}
}

src_install() {
	# Wrapper script to launch mono
	make_wrapper "${PN}" "mono /usr/$(get_libdir)/${PN}/wdmrc.exe"

	insinto "/usr/$(get_libdir)/${PN}/"
	doins WDMRC.Console/bin/Release/*
}

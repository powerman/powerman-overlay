# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 mono-env eutils

DESCRIPTION="WebDAV emulator for Mail.ru Cloud"
HOMEPAGE="https://github.com/yar229/WebDavMailRuCloud"
SRC_URI=""
EGIT_REPO_URI="https://github.com/yar229/WebDavMailRuCloud"
EGIT_COMMIT="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/mono-4.6.2.16
	dev-dotnet/nuget"
RDEPEND=">=dev-lang/mono-4.6.2.16"

src_prepare() {
	default
	nuget restore WebDAVMailRuCloud.sln
}

src_compile() {
	xbuild /property:Configuration=Release || die
	mv WDMRC.Console/bin/Release/{nwebdav.server.dll,NWebDav.Server.dll} || die
}

src_install() {
	insinto "/usr/$(get_libdir)/${PN}/"
	doins WDMRC.Console/bin/Release/*

	make_wrapper "${PN}" "mono /usr/$(get_libdir)/${PN}/wdmrc.exe"
}

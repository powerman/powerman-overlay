# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 vala

DESCRIPTION="Proxy StatusNotifierItems as XEmbedded systemtray-spec icons"
HOMEPAGE="https://git.sr.ht/~steef/snixembed"

EGIT_REPO_URI="https://git.sr.ht/~steef/snixembed"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/vala:=
	>=x11-libs/gtk+-3.0:3
	>=dev-libs/glib-2.0:2
	dev-libs/libdbusmenu[gtk3]"
RDEPEND="${DEPEND}"

src_prepare() {
	vala_src_prepare
	sed -i -e 's/valac/$(VALAC)/' makefile || die "failed to patch makefile"
	default
}

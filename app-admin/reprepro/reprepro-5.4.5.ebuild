# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Debian APT repository creator and maintainer application"
HOMEPAGE="https://salsa.debian.org/brlink/reprepro"
SRC_URI="http://ftp.debian.org/debian/pool/main/r/${PN}/${P/-/_}.orig.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="archive bzip2 gpg lzma"

DEPEND="sys-libs/db:=
	sys-libs/zlib
	gpg? ( app-crypt/gpgme:1= dev-libs/libgpg-error )
	archive? ( app-arch/libarchive:0= )
	lzma? ( app-arch/lzma )"
RDEPEND="${DEPEND}"

src_configure() {
	./autogen.sh
	econf \
		"$(use_with archive libarchive)" \
		"$(use_with bzip2 libbz2)" \
		"$(use_with gpg libgpgme)" \
		"$(use_with lzma liblzma)"
}

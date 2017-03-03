# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Adds support for Telegram to Pidgin and Finch."
HOMEPAGE="https://github.com/majn/telegram-purple"
EGIT_REPO_URI="https://github.com/majn/telegram-purple"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+webp"

DEPEND="sys-devel/gettext
	dev-libs/libgcrypt:0/20
	webp? ( media-libs/libwebp )
	net-im/pidgin
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable webp libwebp)
}

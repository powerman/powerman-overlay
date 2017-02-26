# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=3

inherit eutils

DESCRIPTION="Tool for splitting audio CD image to tracks with cue sheet info."
HOMEPAGE="http://code.google.com/p/cue2tracks/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="flake flaccl mac tta shorten wavpack mp3 aac vorbis"

DEPEND=""

RDEPEND="
	>=media-sound/shntool-3.0.0
	app-shells/bash
	media-libs/flac
	app-cdr/cuetools
	flake? ( media-sound/flake )
	flaccl? ( media-sound/flaccl )
	mac? ( media-sound/mac media-sound/apetag )
	tta? ( media-sound/ttaenc )
	shorten? ( media-sound/shorten )
	wavpack? ( media-sound/wavpack media-sound/apetag )
	mp3? ( media-sound/lame media-sound/id3v2 )
	vorbis? ( media-sound/vorbis-tools )
	aac? ( media-libs/faac media-libs/faad2 )
	"

src_prepare() {
	use flaccl && epatch "${FILESDIR}/flacuda-0.2.16.patch"
}

src_install() {
	dobin "${PN}" || die
	dodoc AUTHORS INSTALL ChangeLog README TODO
}

pkg_postinst() {
	echo ""
	einfo 'To get help about usage run "$ cue2tracks -h"'
	echo ""
}

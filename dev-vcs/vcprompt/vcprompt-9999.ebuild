# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit mercurial autotools

DESCRIPTION="show info about the current working directory for various VCS for PS1"
HOMEPAGE="https://bitbucket.org/powerman/vcprompt"
EHG_REPO_URI="https://bitbucket.org/powerman/vcprompt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default
	eautoconf
}

src_install() {
	dobin vcprompt
	dobin vcprompt-hgst
	doman vcprompt.1
	einstalldocs
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EHG_REPO_URI="https://go.googlecode.com/hg/"
inherit elisp-common bash-completion mercurial

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="http://www.golang.org"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="bash-completion emacs vim-syntax zsh-completion hardened"

DEPEND="sys-apps/ed"
RDEPEND="bash-completion? ( app-shells/bash-completion )
	emacs? ( virtual/emacs )
	vim-syntax? ( app-editors/vim )
	zsh-completion? ( app-shells/zsh-completion )"

S="${WORKDIR}/hg"

src_compile()
{
	use hardened && epatch "${FILESDIR}"/go-tip-chpax.patch

	export HOST_EXTRA_CFLAGS="${CFLAGS}"
	export HOST_EXTRA_LDFLAGS="${LDFLAGS}"
	export GOROOT_FINAL=/usr/lib/go
	export GOROOT="$(pwd)"
	export GOBIN="$GOROOT/bin"

	cd src
	./all.bash
	cd ..
	if use emacs; then
		elisp-compile misc/emacs/*.el
	fi
}

src_install()
{
	dobin bin/*

	dodir /usr/lib/go
	insinto /usr/lib/go
	doins -r pkg
	dodir /usr/lib/go/src
	insinto /usr/lib/go/src
	doins src/Make*

	insinto /usr/share/go
	dodoc AUTHORS CONTRIBUTORS README
	dodoc doc/go_tutorial.txt

	newenvd "${FILESDIR}/go.envd"  90go \
		|| die "Could not install the environment file"

	if use bash-completion; then
		dobashcompletion "misc/bash/go"
	fi

	if use emacs; then
		elisp-install ${PN} misc/emacs/*.el misc/emacs/*.elc
	fi

#	if use kde; then
#		insinto idontknow
#		doins "misc/kate/go.xml"
#	fi

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins misc/vim/syntax/*
		insinto /usr/share/vim/vimfiles/ftdetect
		doins misc/vim/ftdetect/*
	fi

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		doins "misc/zsh/go"
	fi
}

pkg_postinst()
{
	if use emacs; then
		elisp-site-regen
	fi
}

pkg_postrm()
{
	if use emacs; then
		elisp-site-regen
	fi
}

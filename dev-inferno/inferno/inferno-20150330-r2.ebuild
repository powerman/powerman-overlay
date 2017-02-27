# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
MULTILIB_COMPAT=( abi_x86_32 )

inherit mercurial git-r3 pax-utils multilib-build

DESCRIPTION="OS Inferno Fourth Edition"
HOMEPAGE="https://bitbucket.org/inferno-os/inferno-os"
SRC_URI=""

LICENSE="GPL-2"
SLOT=0
KEYWORDS="-* ~x86 ~amd64"
IUSE="X doc source re2 cjson ipv6"

DEPEND="re2? ( dev-libs/re2[${MULTILIB_USEDEP}] )
	X? (
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXext[${MULTILIB_USEDEP}]
	)"
RDEPEND=""

EHG_REPO_URI="https://bitbucket.org/inferno-os/inferno-os"
EHG_REVISION="7110524"

RE2_EGIT_REPO_URI="https://github.com/powerman/inferno-re2"
RE2_EGIT_COMMIT=1.3.0
RE2_EGIT_CHECKOUT_DIR="$WORKDIR"/re2

CJSON_EGIT_REPO_URI="https://github.com/powerman/inferno-cjson"
CJSON_EGIT_COMMIT=0.3.3
CJSON_EGIT_CHECKOUT_DIR="$WORKDIR"/cjson

PATCHES=(
	"$FILESDIR"/issue-122-csendalt.patch
	"$FILESDIR"/issue-147-wait.patch
	"$FILESDIR"/issue-271-microsec.patch
	"$FILESDIR"/issue-274-execatidle.patch
	"$FILESDIR"/issue-287-man-index.patch
)

src_unpack() {
	mercurial_src_unpack

	if use re2; then
		git-r3_fetch "$RE2_EGIT_REPO_URI" "$RE2_EGIT_COMMIT"
		git-r3_checkout "$RE2_EGIT_REPO_URI" "$RE2_EGIT_CHECKOUT_DIR"
		cp -a "$RE2_EGIT_CHECKOUT_DIR"/* "$S" || die
	fi
	if use cjson; then
		git-r3_fetch "$CJSON_EGIT_REPO_URI" "$CJSON_EGIT_COMMIT"
		git-r3_checkout "$CJSON_EGIT_REPO_URI" "$CJSON_EGIT_CHECKOUT_DIR"
		cp -a "$CJSON_EGIT_CHECKOUT_DIR"/* "$S" || die
	fi
}

src_prepare() {
	default

	if ! use ipv6; then
		sed -i 's/ipif6/ipif/g' emu/Linux/emu emu/Linux/emu-g || die
	fi
	if use re2; then
		./patch.re2 || die
	fi
	if use cjson; then
		./patch.cjson || die
	fi
}

src_compile() {
	export INFERNO_ROOT="$S"
	sed -i "s:^ROOT=.*:ROOT=${INFERNO_ROOT}:" mkconfig || die
	sed -i 's/^SYSHOST=.*/SYSHOST=Linux/' mkconfig || die
	sed -i 's/^OBJTYPE=.*/OBJTYPE=386/' mkconfig || die

	export PATH="${INFERNO_ROOT}/Linux/386/bin:${PATH}"
	sh makemk.sh || die
	mk nuke || die
	mk mkdirs || die
	if use X; then
		mk install || die
	fi
	mk CONF=emu-g install || die

	pax-mark pems Linux/386/bin/emu*

	# needed to allow rebuilding already installed inferno (with "use source")
	export INFERNO_ROOT="/usr/inferno"
	sed -i "s:^ROOT=.*:ROOT=${INFERNO_ROOT}:" mkconfig || die
}

src_install() {
	insinto /usr/inferno
	doins -r *
	if use source; then
		doins -r .hg*
	fi

	# Fix permissions
	while IFS="" read -d $'\0' -r f ; do
		fperms +x /usr/inferno/"$f"
	done < <(find Linux/386/bin/ dis/ -type f -not -name '*.dis' -print0)
	fperms 0600 /usr/inferno/keydb/keys

	# Cleanup extra files
	pushd "$D"/usr/inferno || die
	if ! use X; then
		cp Linux/386/bin/emu{-g,} || die
	fi
	if ! use doc; then
		rm -rf doc || die
	fi
	if ! use source; then
		rm -rf {DragonFly,FreeBSD,Hp,Inferno,Irix,MacOSX,NetBSD,Nt,OpenBSD,Plan9,Solaris} || die
		rm -rf {asm,emu,include,lib?*,limbo,mkfiles,os,tools,utils} || die
		rm -rf {makemk.sh,mkconfig,mkfile} || die
	fi
	popd || die

	# Custom files
	insinto /usr/inferno/lib/sh
	newins "$FILESDIR"/profile.env profile

	# Setup the path environment
	doenvd "$FILESDIR"/20inferno
}

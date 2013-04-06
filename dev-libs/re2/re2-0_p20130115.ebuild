# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/re2/re2-0_p20130115.ebuild,v 1.3 2013/04/04 20:16:33 ago Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="An efficent, principled regular expression library"
HOMEPAGE="http://code.google.com/p/re2/"
SRC_URI="http://re2.googlecode.com/files/${PN}-${PV##*_p}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="multilib static-libs"

EMULTILIB_PKG="true"

DEPEND="!!dev-libs/libre2"

# TODO: the directory in the tarball should really be versioned.
S="${WORKDIR}"

re2_get_install_abis() {
	use multilib && get_install_abis || echo ${ABI:-default}
}

src_unpack() {
	local OABI=${ABI}
	for ABI in $(re2_get_install_abis)
	do
		mkdir -p "${WORKDIR}"/${ABI} || die
		cd "${WORKDIR}"/${ABI} || die
		unpack ${A}
	done
	ABI=${OABI}
}

src_prepare() {
	local OABI=${ABI}
	for ABI in $(re2_get_install_abis)
	do
		einfo "Preparing ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${PN} || die

		# Fix problems with FilteredRE2 symbols not being exported.
		epatch "${FILESDIR}/${PN}-symbols-r0.patch"

	done
	ABI=${OABI}
}

emake_re2() {
	# The Makefiles need these environments, but multilib_toolchain_setup()
	# does not export anything when there is only one default abi available.
	makeopts=(
		AR="$(tc-getAR)"
		CXX="$(tc-getCXX)"
		CXXFLAGS="${CXXFLAGS} -pthread $(get_abi_CFLAGS)"
		LDFLAGS="${LDFLAGS} -pthread $(get_abi_CFLAGS)"
		NM="$(tc-getNM)"
    )
	emake "${makeopts[@]}" "$@"
}

src_compile() {
	local OABI=${ABI}
	for ABI in $(re2_get_install_abis)
	do
		einfo "Compiling ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${PN} || die
		emake_re2
	done
	ABI=${OABI}
}

src_test() {
	local OABI=${ABI}
	for ABI in $(re2_get_install_abis)
	do
		einfo "Testing ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${PN} || die
		emake_re2 shared-test
	done
	ABI=${OABI}
}

src_install() {
	local OABI=${ABI}
	for ABI in $(re2_get_install_abis)
	do
		einfo "Installing ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${PN} || die

		emake_re2 DESTDIR="${ED}" prefix=usr libdir=usr/$(get_libdir) install
		if ! use static-libs; then
			rm "${ED}/usr/$(get_libdir)/libre2.a" || die
		fi
		dodoc AUTHORS CONTRIBUTORS README doc/syntax.txt
		dohtml doc/syntax.html

	done
	ABI=${OABI}
}

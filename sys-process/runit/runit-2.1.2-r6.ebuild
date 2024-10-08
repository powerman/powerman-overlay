# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A UNIX init scheme with service supervision"
HOMEPAGE="https://smarden.org/runit/"
PATCH_VER=20240905
SRC_URI="
	https://smarden.org/runit/${P}.tar.gz
	https://github.com/clan/runit/releases/download/${PV}-r5/${P}-patches-${PATCH_VER}.tar.xz
"
S=${WORKDIR}/admin/${P}/src

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="split-usr static"

src_unpack() {
	unpack ${P}.tar.gz
	unpack ${P}-patches-${PATCH_VER}.tar.xz
}

src_prepare() {
	default

	cd "${S}"/.. || die
	eapply -p3 "${WORKDIR}"/patches
	cd "${S}" || die

	# We either build everything or nothing static
	sed -i -e 's:-static: :' Makefile || die

	# see https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=726008
	[[ ${COMPILER} == "diet" ]] &&
		use ppc &&
		filter-flags "-mpowerpc-gpopt"
}

src_configure() {
	use static && append-ldflags -static

	echo "$(tc-getCC) ${CFLAGS}"  > conf-cc || die
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld || die
}

src_install() {
	dobin $(<../package/commands)
	dodir /sbin
	mv "${ED}"/usr/bin/{runit-init,runit,utmpset} "${ED}"/sbin/ || die "dosbin"
	if use split-usr ; then
		dosym ../etc/runit/2 /sbin/runsvdir-start
	else
		dosym ../../etc/runit/2 /sbin/runsvdir-start
	fi

	DOCS=( ../package/{CHANGES,README,THANKS,TODO} )
	HTML_DOCS=( ../doc/*.html )
	einstalldocs
	doman ../man/*.[18]

	# make sv command work
	newenvd - 20runit <<- EOF
		#/etc/env.d/20runit
		SVDIR="/etc/service/"
	EOF
}

default_config() {
	if [[ ! -e "${EROOT}"/etc/runit/runsvdir/current ]]; then
		mkdir -p "${EROOT}"/etc/runit/runsvdir/default || die
		ln -snf default "${EROOT}"/etc/runit/runsvdir/current || die
	fi
	ln -snf runit/runsvdir/current "${EROOT}"/etc/service || die
}

migrate_from_211() {
	# Create /etc/service and /var/service if requested
	if [[ -e "${T}"/make_var_service ]]; then
		ln -sf "${EROOT}"/etc/runit/runsvdir/current "${EROOT}"/etc/service || die
		ln -sf "${EROOT}"/etc/runit/runsvdir/current "${EROOT}"/var/service || die
	fi
	if [[ -d "${T}"/runsvdir ]]; then
		cp -a "${T}"/runsvdir "${EROOT}"/etc/runit || die
	fi
	return 0
}

pkg_preinst() {
	if  has_version '<sys-process/runit-2.1.2'; then
		pre_212=yes
	fi
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		default_config
	elif [[ -n ${pre_212} ]]; then
		migrate_from_211
	fi

	ewarn "To make sure sv works correctly in your currently open"
	ewarn "shells, please run the following command:"
	ewarn
	ewarn "source /etc/profile"
	ewarn

	if [[ -L "${EROOT}"/var/service ]]; then
		ewarn "Once this version of runit is active, please remove the"
		ewarn "compatibility symbolic link at ${EROOT}/var/service"
		ewarn "The correct path now is ${EROOT}/etc/service"
		ewarn
	fi

	if [[ -L "${EROOT}"/etc/runit/runsvdir/all ]]; then
		ewarn "${EROOT}/etc/runit/runsvdir/all has moved to"
		ewarn "${EROOT}/etc/sv."
		ewarn "Any symbolic links under ${EROOT}/etc/runit/runsvdir"
		ewarn "which point to services through ../all should be updated to"
		ewarn "point to them through ${EROOT}/etc/sv."
		ewarn "Once that is done, ${EROOT}/etc/runit/runsvdir/all should be"
		ewarn "removed."
		ewarn
	fi
}

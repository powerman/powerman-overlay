# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs prefix xdg

DESCRIPTION="X11 window manager featuring tabs and an iconbar"
HOMEPAGE="http://www.fluxbox.org"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3 autotools
	# the offical repo does not have tls git://git.fluxbox.org/fluxbox.git -- using mirror
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~sparc x86 ~amd64-linux ~x86-linux"
	SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
IUSE="nls xinerama bidi +truetype +imlib +slit +systray +toolbar vim-syntax"

REQUIRED_USE="systray? ( toolbar )"

RDEPEND="bidi? ( >=dev-libs/fribidi-0.19.2 )
	imlib? ( >=media-libs/imlib2-1.2.0[X] )
	truetype? ( media-libs/freetype )
	vim-syntax? ( app-vim/fluxbox-syntax )
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	xinerama? ( x11-libs/libXinerama )
	|| ( x11-misc/gxmessage x11-apps/xmessage )"

BDEPEND="bidi? ( virtual/pkgconfig )
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	x11-base/xorg-proto"

src_prepare() {

	default
	# We need to be able to include directories rather than just plain
	# files in menu [include] items. This patch will allow us to do clever
	# things with style ebuilds.
	eapply "${FILESDIR}"/gentoo_style_location-1.1.x.patch

	eprefixify util/fluxbox-generate_menu.in

	eapply "${FILESDIR}"/osx-has-otool.patch

	# Add in the Gentoo -r number to fluxbox -version output.
	if [[ "${PR}" == "r0" ]] ; then
		suffix="gentoo"
	else
		suffix="gentoo-${PR}"
	fi
	if [[ ${PV} == 9999 ]]; then
		suffix="$(git rev-parse --short HEAD)-gentoo"
	fi
	sed -i \
		-e "s~\(__fluxbox_version .@VERSION@\)~\1-${suffix}~" \
		version.h.in || die "version sed failed"

	eautoreconf
}

src_configure() {
	xdg_environment_reset

	use bidi && append-cppflags "$($(tc-getPKG_CONFIG) --cflags fribidi)"

	econf \
		$(use_enable bidi fribidi ) \
		$(use_enable imlib imlib2) \
		$(use_enable nls) \
		$(use_enable slit ) \
		$(use_enable systray ) \
		$(use_enable toolbar ) \
		$(use_enable truetype xft) \
		$(use_enable xinerama) \
		--sysconfdir="${EPREFIX}"/etc/X11/${PN} \
		--with-style="${EPREFIX}"/usr/share/fluxbox/styles/Emerge
}

src_compile() {
	emake AR="$(tc-getAR)"

	mkdir -p "${T}/home/.fluxbox" || die "mkdir home failed"
	# Call fluxbox-generate_menu through bash since it lacks +x
	# chmod 744 may be an equal fix
	MENUFILENAME="${S}/data/menu" MENUTITLE="Fluxbox ${PV}" \
		CHECKINIT="no. go away." HOME="${T}/home" \
		bash "${S}/util/fluxbox-generate_menu" -is -ds \
		|| die "menu generation failed"
}

src_install() {
	emake DESTDIR="${D}" STRIP="" install
	dodoc README* AUTHORS TODO* ChangeLog NEWS

	# Install the generated menu
	insinto /usr/share/fluxbox
	doins data/menu

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}.xsession fluxbox

	# Styles menu framework
	insinto /usr/share/fluxbox/menu.d/styles
	doins "${FILESDIR}"/styles-menu-fluxbox
	doins "${FILESDIR}"/styles-menu-commonbox
	doins "${FILESDIR}"/styles-menu-user
}

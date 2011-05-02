# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="mc"
MY_P="${MY_PN}-${PV/_/-}"

DESCRIPTION="GNU Midnight Commander cli-based file manager. 4.1.x branch"
HOMEPAGE="http://mc.linuxinside.com/cgi-bin/dir.cgi"
SRC_URI="http://mc.linuxinside.com/Releases/${MY_P}.tar.bz2"

SLOT=0
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"
IUSE="${IUSE} gpm nls ncurses slang"

DEPEND=">=sys-fs/e2fsprogs-1.19
	ncurses? ( >=sys-libs/ncurses-5.2-r5 )
	>=sys-libs/pam-0.72 
	gpm? ( >=sys-libs/gpm-1.19.3 )
	slang? ( >=sys-libs/slang-1.4.2 )
	!app-misc/mc"


S="${WORKDIR}/${MY_P}"

src_unpack() {
    unpack ${A}
    EPATCH_FORCE="yes"
    EPATCH_SUFFIX="patch" 
    epatch ${FILESDIR}/${PV}
}

src_compile() {


	local myconf=""

	if ! use slang && ! use ncurses ; then
		myconf="${myconf}"
	elif
		use ncurses && ! use slang ; then
			myconf="${myconf} --with-ncurses --without-included-slang"
	else
		use slang && myconf="${myconf} --with-included-slang --with-terminfo --with-slang"
	fi

	myconf="${myconf} `use_with gpm gpm-mouse`"

	use nls \
		&& myconf="${myconf} --with-included-gettext" \
		|| myconf="${myconf} --disable-nls"


	econf \
	--with-vfs \
	--with-gnu-ld \
	--with-ext2undel \
	--with-edit \
	--enable-charset \
	--with-mcfs \
	--with-subshell \
	--with-netrc \
	--with-dusum \
	${myconf} || die

	emake || die
}

src_install() {


	einstall || die

    rm -rf ${D}/usr/man ${D}/usr/share/man
    doman ${S}/doc/*.1
    doman ${S}/doc/*.8
    
    dodoc ABOUT-NLS COPYING FAQ INSTALL* NEWS README.* Specfile
    cd ${S}/doc
    dodoc DEVEL FILES LSM lsm.LSM

    insinto /etc/pam.d
    newins ${FILESDIR}/mcserv.pamd mcserv
    
    exeinto /etc/init.d
    newexe ${FILESDIR}/mcserv.rc mcserv
    
    exeinto /etc/profile.d
    doexe ${S}/lib/mc.sh
    doexe ${S}/lib/mc.csh    

    insinto /usr/lib/mc/syntax
    doins ${FILESDIR}/ebuild.syntax

}


# Local Variables:
# mode: sh
# End:


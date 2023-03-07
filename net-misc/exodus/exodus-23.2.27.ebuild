# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Cryptocurrency Wallet"
HOMEPAGE="https://www.exodus.com/"

SRC_URI="https://downloads.exodus.com/releases/exodus-linux-x64-${PV}.deb"

LICENSE="all-rights-reserved no-source-code"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PREBUILT="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	unpack "exodus-linux-x64-${PV}.deb"
        unpack "${WORKDIR}/data.tar.xz"

        mkdir -p "${S}"/opt
        mv  "${WORKDIR}"/usr "${S}"/
        mv "${S}"/usr/lib/exodus "${S}"/opt/exodus

}

src_install() {
        insinto /

        dodoc usr/share/doc/exodus/copyright
        rm -rf "${WORKDIR}"/"${P}"/usr/share/doc

	rm "${WORKDIR}"/"${P}"/usr/bin/exodus
	echo "#!/bin/bash" > "${WORKDIR}"/"${P}"/usr/bin/exodus
	echo "LC_TIME=C exec /opt/exodus/Exodus" >> "${WORKDIR}"/"${P}"/usr/bin/exodus


        dobin usr/bin/exodus
        rm -rf "${WORKDIR}"/"${P}"/usr/bin

        mkdir -p "${D}"/opt
        mv  "${S}"/opt/exodus "${D}"/opt/exodus || die "Installation failed"
        cp -pPR  "${WORKDIR}"/"${P}"/usr/share "${D}"/usr || die "Installation failed"

#        rm -Rf "${D}"/opt/insync/.build-id
#        rm -rf "${D}"/usr/share/man/man1/


#        insinto /usr/share/mime/packages
#        doins usr/share/mime/packages/insync-helper.xml

	fperms 4755 "/opt/exodus/chrome-sandbox"
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Google Cloud SDK"
HOMEPAGE="https://cloud.google.com/sdk"
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${P}-linux-x86_64.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/google-cloud-sdk"

src_install() {
	dodir /usr/share/google-cloud-sdk
	cp -a * "${D}"/usr/share/google-cloud-sdk
	dosym ../share/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
}

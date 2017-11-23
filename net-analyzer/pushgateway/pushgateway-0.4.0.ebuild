# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user golang-build golang-vcs-snapshot

EGO_REPO="github.com/prometheus/pushgateway"
EGO_PN="${EGO_REPO}"
EGIT_COMMIT="v${PV}"

DESCRIPTION="Allow ephemeral and batch jobs to expose their metrics to Prometheus"
HOMEPAGE="https://github.com/prometheus/pushgateway"
SRC_URI="https://${EGO_REPO}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/promu
	dev-go/go-bindata"
RDEPEND=""

S="${WORKDIR}/${P}/src/${EGO_REPO}"

DOCS=( README.md CHANGELOG.md CONTRIBUTING.md )

pkg_setup() {
	enewgroup "$PN"
	enewuser "$PN" -1 -1 -1 "$PN"
}

src_prepare() {
	default
	sed -i -e "s/{{.Revision}}/${EGIT_COMMIT}/" .promu.yml || die
}

src_compile() {
	GOPATH="${WORKDIR}/${P}" promu build -v --prefix bin/"$PN" || die
}

src_install() {
	dobin bin/pushgateway/"$PN"
	einstalldocs
	keepdir /var/lib/"$PN"
	fowners "$PN":"$PN" /var/lib/"$PN"
}

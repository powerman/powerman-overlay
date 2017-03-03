# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user golang-build golang-vcs-snapshot

EGO_REPO="github.com/prometheus/alertmanager"
EGO_PN="${EGO_REPO}/cmd/..."
EGIT_COMMIT="v${PV}"

DESCRIPTION="Handles alerts sent by client applications such as the Prometheus"
HOMEPAGE="https://github.com/prometheus/alertmanager"
SRC_URI="https://${EGO_REPO}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/promu"
RDEPEND=""

S="${WORKDIR}/${P}/src/${EGO_REPO}"

DOCS=( README.md CHANGELOG.md CONTRIBUTING.md doc )

pkg_setup() {
	enewgroup alertmanager
	enewuser alertmanager -1 -1 -1 alertmanager
}

src_unpack() {
	local EGO_PN="$EGO_REPO" # work around #611448
	golang-vcs-snapshot_src_unpack # not sure why, but it can't be called as default()
}

src_prepare() {
	default
	sed -i -e "s/{{.Revision}}/${EGIT_COMMIT}/" .promu.yml || die
}

src_compile() {
	GOPATH="${WORKDIR}/${P}" promu build -v --prefix bin || die
}

src_install() {
	dobin bin/alertmanager
	einstalldocs
	keepdir /etc/alertmanager
	keepdir /var/lib/alertmanager
	fowners alertmanager:alertmanager /var/lib/alertmanager
}

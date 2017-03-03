# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user golang-build golang-vcs-snapshot

EGO_REPO="github.com/ncabatoff/process-exporter"
EGO_PN="${EGO_REPO}/cmd/process-exporter"
EGIT_COMMIT="v${PV}"

DESCRIPTION="Prometheus exporter that mines /proc to report on selected processes"
HOMEPAGE="https://github.com/ncabatoff/process-exporter"
SRC_URI="https://${EGO_REPO}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${P}/src/${EGO_REPO}"

src_unpack() {
	local EGO_PN="$EGO_REPO" # work around #611448
	golang-vcs-snapshot_src_unpack # not sure why, but it can't be called as default()
}

src_install() {
	dobin "$PN"
	einstalldocs
	insinto /etc/"$PN"
	doins "$FILESDIR"/config.yml
}

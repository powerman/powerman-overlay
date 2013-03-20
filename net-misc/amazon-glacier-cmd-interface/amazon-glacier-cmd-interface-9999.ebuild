# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils git-2

DESCRIPTION="Command line interface for Amazon Glacier"
HOMEPAGE="https://github.com/uskudnik/amazon-glacier-cmd-interface"
SRC_URI=""
EGIT_REPO_URI="git://github.com/uskudnik/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="
		>=dev-python/boto-2.6.0
		dev-python/python-dateutil
		dev-python/pytz
		virtual/python-argparse
		dev-python/prettytable
		"

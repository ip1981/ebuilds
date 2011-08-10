# Copyright 2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils


DESCRIPTION="YAML parser and emitter in C++ matching the YAML 1.2 spec"
LICENSE="MIT"
HOMEPAGE="http://code.google.com/p/yaml-cpp/"
SRC_URI="http://yaml-cpp.googlecode.com/files/${P}.tar.gz"
SLOT="0"

# No version in root dir of tarball:
S="${WORKDIR}/${PN}"

KEYWORDS="~x86 ~amd64"
IUSE="+shared-libs +static-libs"
REQUIRED_USE="|| ( shared-libs static-libs )"


src_prepare() {
	epatch "${FILESDIR}/gcc4.6-null.patch"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build static-libs STATIC_LIBS)
		$(cmake-utils_use_build shared-libs SHARED_LIBS)
		)

	cmake-utils_src_configure
}


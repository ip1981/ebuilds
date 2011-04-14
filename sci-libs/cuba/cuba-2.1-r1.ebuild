# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI="2"

DESCRIPTION="A library for multidimensional numerical integration"
HOMEPAGE="http://www.feynarts.de/cuba/"
LICENSE="LGPL"
SRC_URI="http://www.feynarts.de/cuba/Cuba-${PV}.tar.gz"
S=${WORKDIR}/Cuba-${PV}

KEYWORDS="~amd64 ~x86"
IUSE="+static-libs +shared-libs doc examples"
SLOT="0"


src_prepare() {
	if use shared-libs; then
		epatch "${FILESDIR}/shared.patch"
	elif use !static-libs; then
		eerror "Must USE shared-libs or static-libs"
		die
	fi
}

src_configure() {
	econf
}

src_compile() {
	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
		emake lib || die "emake failed"
	else
		die "No Makefile"
	fi
}

#src_test() {
#	emake check
#}


src_install() {
	use static-libs && dolib.a libcuba.a
	use shared-libs && dolib.so libcuba.so*
	use doc && dodoc cuba.pdf ChangeLog
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demo
	fi
	insinto /usr/include
	doins cuba.h
}


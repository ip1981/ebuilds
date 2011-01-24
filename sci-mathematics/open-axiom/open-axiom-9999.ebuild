# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils autotools subversion

DESCRIPTION="The open scientific computation system (Axiom fork)"
HOMEPAGE="http://open-axiom.org"
ESVN_REPO_URI="https://open-axiom.svn.sf.net/svnroot/open-axiom/trunk"
ESVN_PROJECT="open-axiom"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Failed to build with -static-libs
IUSE="+sbcl -clisp X threads"

RDEPEND="X? ( x11-libs/libXpm x11-libs/libXau x11-libs/libSM x11-libs/libxcb
x11-libs/libXdmcp x11-libs/libICE )
sbcl?  ( >=dev-lisp/sbcl-1.0.22 )
clisp? ( >=dev-lisp/clisp-2.47 )"


DEPEND="${RDEPEND}
app-text/noweb"

src_prepare() {
	eautoreconf
}

src_configure() {
	if use sbcl && ! use clisp; then
		lisp=sbcl
	elif use clisp && ! use sbcl; then
		lisp=clisp
	else
		die "Must use sbcl OR clisp"
	fi

	econf \
		$(use_with X x) \
		--with-lisp=$lisp \
		$(use_enable threads threads) \
		|| die "econf failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog* NEWS README AUTHORS MAINTAINERS TODO STYLES INSTALL
}


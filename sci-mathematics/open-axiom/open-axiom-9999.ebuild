# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils autotools subversion

DESCRIPTION="The open computer algebra system (Axiom fork)"
HOMEPAGE="http://open-axiom.org"
ESVN_REPO_URI="https://open-axiom.svn.sf.net/svnroot/open-axiom/trunk"
ESVN_PROJECT="open-axiom"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LISPS='sbcl clisp gcl ecls clozurecl'
REQUIRED_USE="^^ ( $LISPS )"

# The first lisp is default
IUSE="X threads +$LISPS"



RDEPEND="X? ( x11-libs/libXpm
x11-libs/libXau
x11-libs/libSM
x11-libs/libxcb
x11-libs/libXdmcp
x11-libs/libICE )"

DEPEND="${RDEPEND}
app-text/noweb
sbcl?      ( >=dev-lisp/sbcl-1.0.22 !=dev-lisp/sbcl-1.0.29 )
clisp?     ( >=dev-lisp/clisp-1.44 )
gcl?       ( || ( =dev-lisp/gcl-2.6.7 =dev-lisp/gcl-2.6.8 ) )
ecls?      ( >=dev-lisp/ecls-0.9l  )
clozurecl? ( >=dev-lisp/clozurecl-1.3 )"


src_prepare() {
	eautoreconf
}

src_configure() {
	local l, lisp;
	for l in $LISPS; do
		use $l && break;
	done

	case $l in
		clozurecl) lisp=ccl;;
		ecls)      lisp=ecl;;
		*)         lisp=$l;;
	esac

	econf \
		$(use_with X x) \
		--disable-gcl \
		--with-lisp=$lisp \
		$(use_enable threads threads) \
		|| die "econf failed"
}

src_compile() {
	# Parallel make broken
	emake -j1 || die "emake failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog* NEWS README AUTHORS MAINTAINERS TODO STYLES INSTALL
	doicon ${FILESDIR}/open-axiom.png
	make_desktop_entry \
		open-axiom \
		OpenAxiom \
		open-axiom \
		"" \
		"Terminal=true"
}


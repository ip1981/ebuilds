EAPI=2

MODULE_AUTHOR=RSCHUPP
inherit perl-module

DESCRIPTION="PAR component that can generate stand-alone executables and '.par' archives"

SLOT="0"
KEYWORDS="amd64 x86 ~x86-solaris"
IUSE=""

DEPEND="
>=dev-perl/Archive-Zip-1.00
>=dev-perl/Module-ScanDeps-1.01
>=dev-perl/PAR-Dist-0.22
>=dev-perl/PAR-1.000
>=dev-perl/Getopt-ArgvFile-1.07
"
RDEPEND="${DEPEND}"

SRC_TEST=do


# $NetBSD: Makefile,v 1.2 2018/07/31 05:38:56 schmonz Exp $

DISTNAME=		djbsort-20180717
PKGREVISION=		1
CATEGORIES=		math
MASTER_SITES=		${HOMEPAGE}

MAINTAINER=		schmonz@NetBSD.org
HOMEPAGE=		https://sorting.cr.yp.to/
COMMENT=		Library for sorting arrays of integers
LICENSE=		public-domain

DEPENDS+=		python27-[0-9]*:../../lang/python27

REPLACE_INTERPRETER+=	python27
REPLACE.python27.old=	.*python2\{0,1\}[^ ]*
REPLACE.python27.new=	${LOCALBASE}/bin/python2.7
REPLACE_FILES.python27=	verif/decompose verif/minmax verif/unroll

PYTHON_VERSIONS_INCOMPATIBLE=	27	# so a python3 will be auto-selected

REPLACE_PYTHON=		build test upgrade verif/tryinput
SUBST_CLASSES+=		python3
SUBST_STAGE.python3=	do-configure
SUBST_FILES.python3=	verif/verifymany
SUBST_SED.python3=	-e 's|time python3|time ${PYTHONBIN}|g'

SHAREDIR=		share/${PKGBASE}
FILES_SUBST+=		DIFF=${DIFF:Q}
FILES_SUBST+=		INSTALL_DATA=${INSTALL_DATA:Q}
FILES_SUBST+=		PSEUDO_PLIST=${PSEUDO_PLIST:Q}
FILES_SUBST+=		SHAREDIR=${SHAREDIR:Q}

INSTALLATION_DIRS=	include lib share

pre-configure:
	cd ${WRKSRC} && rm -f *.orig

do-build:
	cd ${WRKSRC} && ./build

do-install:
	cp pseudo-PLIST ${WRKSRC}
	cp -Rp ${WRKSRC} ${DESTDIR}${PREFIX}/${SHAREDIR}

.include "../../lang/python/application.mk"
.include "../../mk/bsd.pkg.mk"

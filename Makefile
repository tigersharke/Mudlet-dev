### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=		mudlet
DISTVERSION=	g20260509
CATEGORIES=		games
MASTER_SITES=	GH
PKGNAMESUFFIX=	-dev
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block ##--------------------------------------------------------------------------------------
MAINTAINER=		nope@nothere
COMMENT=		Cross-platform, open source, super fast MUD client with lua scripting
WWW=			https://mudlet.org/

### License block ##---------------------------------------------------------------------------------------
LICENSE=		GPLv2+
LICENSE_FILE=	${WRKSRC}/COPYING

# dependencies ##------------------------------------------------------------------------------------------
LIB_DEPENDS=	libassimp.so:multimedia/assimp \
				libboost_thread.so:devel/boost-libs \
				libcurl.so:ftp/curl \
				libzstd.so:archivers/zstd
BUILD_DEPENDS=	lua54-luarocks>0:devel/lua-luarocks

### uses block ##------------------------------------------------------------------------------------------
USES=			cmake:noninja gmake lua sqlite qt:6
USE_QT6=		qtkeychain
USE_GITHUB=		yes
GH_ACCOUNT=		Mudlet
GH_PROJECT=		Mudlet
GH_TAGNAME=		4e32ebc58d0abc58418f03145ef54b3b7b7093f8
GH_TUPLE=		Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:3rdparty

# USES=cmake related variables ##--------------------------------------------------------------------------
#
### Make block ##------------------------------------------------------------------------------------------
#
### conflicts ##-------------------------------------------------------------------------------------------
CONFLICTS=		Mudlet mudlet
### wrksrc block ##----------------------------------------------------------------------------------------
#WRKSRC=			${WRKDIR}/${PORTNAME}-${GH_TAGNAME}
### packaging list block ##--------------------------------------------------------------------------------
#
### options definitions ##---------------------------------------------------------------------------------
#
### options descriptions ##--------------------------------------------------------------------------------
#
### options helpers ##-------------------------------------------------------------------------------------
#

.include <bsd.port.options.mk>

post-extract:
	${LOCALBASE}/bin/luarocks54 install luautf8
	${LOCALBASE}/bin/luarocks54 install luafilesystem
	${LOCALBASE}/bin/luarocks54 install lua-zip
	${LOCALBASE}/bin/luarocks54 install luasql-sqlite3
	${LOCALBASE}/bin/luarocks54 install lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 install lpeg
#	${LOCALBASE}/bin/luarocks54 install lua-yajl YAJL_DIR=/usr/local

#----------------------------------------------------------------------

.include <bsd.port.mk>

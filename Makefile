### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=		Mudlet
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
				libzstd.so:archivers/zstd \
				libyajl.so:devel/yajl
BUILD_DEPENDS=	lua54-luarocks>0:devel/lua-luarocks \
				pugixml>0:textproc/pugixml \

### uses block ##------------------------------------------------------------------------------------------
USES=			cmake:noninja gmake lua sqlite qt:5 qt:6
USE_QT=			widgets
USE_QT6=		qtkeychain
USE_GITHUB=		yes
GH_TUPLE= \
				Mudlet:Mudlet:4e32ebc58d0abc58418f03145ef54b3b7b7093f8:DEFAULT \
				Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:3rdparty/edbee-lib \
				martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:3rdparty/lcf \
				julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:3rdparty/qt-tags-widget \
				frankosterfeld:qtkeychain:e3b2e83f01cccadf9257c3143ae6a066b7d02149:3rdparty/qtkeychain \
				getsentry:sentry-native:c0e5f0705da3853ff548c7ece77d639a20e1d8f5:3rdparty/sentry-native

# USES=cmake related variables ##--------------------------------------------------------------------------
#QT_ADDITIONAL_HOST_PACKAGES_PREFIX_PATH
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
#	${MV} ${WRKDIR}/edbee-lib-a3ae51bbb82158366b3d5c4030a54981db688892/* ${WRKDIR}/${PORTNAME}-${GH_TAGNAME}/3rdparty/edbee-lib

#----------------------------------------------------------------------

.include <bsd.port.mk>

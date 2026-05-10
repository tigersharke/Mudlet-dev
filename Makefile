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
				libqt6keychain.so:security/qtkeychain@qt6 \
				libpugixml.so:textproc/pugixml \
				libhunspell-1.7.so:textproc/hunspell \
				libpcre2-8.so:devel/pcre2 \
				libzip.so:archivers/libzip \
				libsysinfo.so:devel/libsysinfo \
				libonig.so:devel/oniguruma \
				libzstd.so:archivers/zstd \
				libcurl.so:ftp/curl \
				libboost_thread.so:devel/boost-libs \
				liblua-5.1.so:lang/lua51
#				libyajl.so:devel/yajl \

BUILD_DEPENDS=	lua54-luarocks>0:devel/lua-luarocks

### uses block ##------------------------------------------------------------------------------------------
USES=			lua cmake:noninja gmake sqlite qt:6 desktop-file-utils gl

GH_ACCOUNT= Mudlet
GH_TAGNAME= 4e32ebc58d0abc58418f03145ef54b3b7b7093f8
USE_GITHUB= nodefaults
GH_TUPLE= \
				Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:fakedir1/3rdparty/edbee-lib \
				martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:fakedir2/3rdparty/lcf \
				julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:fakedir3/3rdparty/qt-tags-widget \
				getsentry:sentry-native:c0e5f0705da3853ff548c7ece77d639a20e1d8f5:fakedir5/3rdparty/sentry-native

USE_QT=			base 5compat multimedia tools
USE_GL=			gl opengl glu

# USES=cmake related variables ##--------------------------------------------------------------------------
#
### Make block ##------------------------------------------------------------------------------------------
#
### conflicts ##-------------------------------------------------------------------------------------------
CONFLICTS=		Mudlet mudlet
### wrksrc block ##----------------------------------------------------------------------------------------
#
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
	${LOCALBASE}/bin/luarocks54 install lua-yajl

#----------------------------------------------------------------------

.include <bsd.port.mk>

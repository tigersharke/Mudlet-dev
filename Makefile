### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=		Mudlet
DISTVERSION=	g20260520
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
				liblua-5.1.so:lang/lua51 \
				libyajl.so:devel/yajl

BUILD_DEPENDS= 	luarocks54:devel/lua-luarocks@lua54 \
				${LOCALBASE}/lib/lua/5.1/bit.so:devel/lua-bitop@lua51 \
				${LOCALBASE}/share/hunspell/en_US.aff:textproc/en-hunspell 

### uses block ##------------------------------------------------------------------------------------------
USES=			lua:51 cmake:noninja gmake sqlite qt:6 desktop-file-utils gl shebangfix pkgconfig:build

GH_ACCOUNT=		Mudlet
GH_TAGNAME=		34a3f7271c4ec1f684f842313ff37d21491b3b13
USE_GITHUB=		nodefaults
GH_TUPLE= \
				Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:edbee_lib/3rdparty/edbee-lib \
				martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:lua_code_formatter/3rdparty/lcf \
				julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:qt_tags_widget/3rdparty/qt-tags-widget \
				frankosterfeld:qtkeychain:e3b2e83f01cccadf9257c3143ae6a066b7d02149:qtkeychain/3rdparty/qtkeychain \
				getsentry:sentry-native:c0e5f0705da3853ff548c7ece77d639a20e1d8f5:sentry_native/3rdparty/sentry-native

USE_GL=			gl opengl glu
USE_QT=			base 5compat multimedia tools speech

# USES=cmake related variables ##--------------------------------------------------------------------------
CMAKE_ARGS=     -DCMAKE_INSTALL_PREFIX="/usr/local"
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

post-stage:
	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lpeg
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luautf8
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-zip
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-yajl
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luafilesystem
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luasql-sqlite3
	${CP} -R ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/* ${LOCALBASE}/lib/lua/5.1/

# The above is definitely weird but I believe everything gets placed where it must for mudlet features to work._REFMODLIBDIR}/lfs.so
# After more investigation, the above is used if there is no port for it, so I am avoiding some luarocks.

# A mudlet error in lua that says 'locale' has nothing to do with system locale like LC_ALL for localization language choice.
# The possible lua error of a variable being nil is a syntax error which has lua code methods to avoid.

#----------------------------------------------------------------------

.include <bsd.port.mk>

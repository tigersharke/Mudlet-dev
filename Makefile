### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=		Mudlet
DISTVERSION=	g20260514
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
				${LUA_REFMODLIBDIR}/lpeg.so:devel/lua-lpeg@lua51 \
				${LUA_REFMODLIBDIR}/lfs.so:devel/luafilesystem@lua51 \
				${LUA_REFMODLIBDIR}/luasql:databases/luasql-sqlite3@lua51

RUN_DEPENDS=	${LOCALBASE}/share/hunspell/en_US.aff:textproc/en-hunspell

### uses block ##------------------------------------------------------------------------------------------
USES=			lua:51 cmake:noninja gmake sqlite qt:6 desktop-file-utils gl

GH_ACCOUNT= Mudlet
GH_TAGNAME=		f8f51c521dfb538c8aadecb980a6820c3d8232ac
USE_GITHUB= nodefaults
GH_TUPLE= \
				Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:fakedir1/3rdparty/edbee-lib \
				martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:fakedir2/3rdparty/lcf \
				julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:fakedir3/3rdparty/qt-tags-widget \
				getsentry:sentry-native:c0e5f0705da3853ff548c7ece77d639a20e1d8f5:fakedir5/3rdparty/sentry-native

USE_GL=			gl opengl glu
USE_QT=			base 5compat multimedia tools speech

# USES=cmake related variables ##--------------------------------------------------------------------------
CMAKE_ARGS=     -DCMAKE_INSTALL_PREFIX="/usr/local" \
				-DLUA_INCLUDE_DIR="/usr/local/include/lua51"
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

pre-build:
	${LOCALBASE}/bin/luarocks54 --tree=${WRKDIR}/rocksdir --lua-version 5.1 install luautf8
	${LOCALBASE}/bin/luarocks54 --tree=${WRKDIR}/rocksdir --lua-version 5.1 install lua-zip
	${LOCALBASE}/bin/luarocks54 --tree=${WRKDIR}/rocksdir --lua-version 5.1 install lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 --tree=${WRKDIR}/rocksdir --lua-version 5.1 install lua-yajl
	cp -R ${WRKDIR}/rocksdir/lib/lua/5.1/* ${LOCALBASE}/lib/lua/5.1/
	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/brimworks
	cp ${WRKDIR}/rocksdir/lib/lua/5.1/brimworks/zip.so ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/brimworks
	cp ${WRKDIR}/rocksdir/lib/lua/5.1/*.so ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/

# The above is definitely weird but I believe everything gets placed where it must for mudlet features to work._REFMODLIBDIR}/lfs.so
# After more investigation, the above is used if there is no port for it, so I could avoid some luarocks.
#
# From lpeg:
#do-install:
#    ${MKDIR} ${STAGEDIR}${LUA_MODLIBDIR} ${STAGEDIR}${LUA_MODSHAREDIR}
#    ${INSTALL_LIB} ${WRKSRC}/lpeg.so ${STAGEDIR}${LUA_MODLIBDIR}
#    ${INSTALL_DATA} ${WRKSRC}/re.lua ${STAGEDIR}${LUA_MODSHAREDIR}

#----------------------------------------------------------------------

.include <bsd.port.mk>

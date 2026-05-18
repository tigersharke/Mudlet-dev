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
				${LOCALBASE}/lib/lua/5.1/bit.so:devel/lua-bitop@lua51 \
				${LOCALBASE}/share/hunspell/en_US.aff:textproc/en-hunspell
#				${LOCALBASE}/lib/lua/5.1/lpeg.so:devel/lua-lpeg@lua51 \
#				${LOCALBASE}/share/lua/lib/lua/5.1/lfs.so:devel/luafilesystem@lua51 \
#				${LOCALBASE}/share/lua/lib/lua/5.1/luasql:databases/luasql-sqlite3@lua51 \


### uses block ##------------------------------------------------------------------------------------------
USES=			lua:51 cmake:noninja gmake sqlite qt:6 desktop-file-utils gl shebangfix

GH_ACCOUNT= Mudlet
GH_TAGNAME=		f8f51c521dfb538c8aadecb980a6820c3d8232ac
USE_GITHUB= nodefaults
GH_TUPLE= \
				Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:fakedir1/3rdparty/edbee-lib \
				martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:fakedir2/3rdparty/lcf \
				julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:fakedir3/3rdparty/qt-tags-widget \
				getsentry:sentry-native:c0e5f0705da3853ff548c7ece77d639a20e1d8f5:fakedir5/3rdparty/sentry-native \
				Mudlet:dblsqd-sdk-qt:692697328a8312c951df12f07f8c8068d8ae24e7:fakedir4/3rdparty/dblsqd \
				Mudlet:qt-ordered-map:ca2a31b7f8f982660b01d7dff6f6bc07eb0dcd34:fakedir6/3rdparty/qt-ordered-map

USE_GL=			gl opengl glu
USE_QT=			base 5compat multimedia tools speech

# USES=cmake related variables ##--------------------------------------------------------------------------
CMAKE_ARGS=     -DCMAKE_INSTALL_PREFIX="/usr/local"
#				-DCMAKE_LIBRARY_PATH="/usr/loca/share" \
#				-DCMAKE_SYSTEM_LIBRARY_PATH="/usr/loca/share" \
#				-DLUA_INCLUDE_DIR="/usr/local/include/lua51"
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

#post-extract:
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lpeg
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luautf8
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-zip
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lrexlib-pcre2
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-yajl
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luafilesystem
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luasql-sqlite3

#pre-stage:
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 remove lpeg
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 remove luautf8
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 remove lua-zip
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 remove lrexlib-pcre2
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 remove lua-yajl
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 remove luafilesystem
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 remove luasql-sqlite3

#pre-build:
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
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/share/lua/5.1/luasql/sqlite3/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/share/lua/5.1/lpeg/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/share/lua/5.1/lfs/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/share/lua/5.1/yajl/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/share/lua/5.1/utf8/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/utf8/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/luasql/sqlite3/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/lpeg/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/lfs/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/yajl/
#	${MKDIR} ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/brimworks/
#	${CP} -R ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/brimworks/* ${LOCALBASE}/lib/lua/5.1/brimworks/

# The above is definitely weird but I believe everything gets placed where it must for mudlet features to work._REFMODLIBDIR}/lfs.so
# After more investigation, the above is used if there is no port for it, so I could avoid some luarocks.

#----------------------------------------------------------------------

.include <bsd.port.mk>

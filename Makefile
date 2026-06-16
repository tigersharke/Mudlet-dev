### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=		Mudlet
DISTVERSION=	g20260615
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
				liblua-5.1.so:lang/lua51 \
				libyajl.so:devel/yajl
#				libonig.so:devel/oniguruma \

BUILD_DEPENDS= 	luarocks54:devel/lua-luarocks@lua54 \
				${LOCALBASE}/lib/lua/5.1/bit.so:devel/lua-bitop@lua51 \
				${LOCALBASE}/share/hunspell/en_US.aff:textproc/en-hunspell \
				${LOCALBASE}/lib/qt6/libQt6UiTools.so:devel/qt6-tools
RUN_DEPENDS=	curl:ftp/curl \
				zstd:archivers/zstd \
				${LOCALBASE}/lib/libboost_atomic.so:devel/boost-libs

### uses block ##------------------------------------------------------------------------------------------
#USES=			lua:51 cmake:outsource ninja sqlite qt:6 desktop-file-utils gl
#USES=			lua:51 cmake:noninja gmake sqlite qt:6 desktop-file-utils gl
USES=			lua:51 cmake sqlite qt:6 desktop-file-utils gl pkgconfig

GH_ACCOUNT=		Mudlet
GH_TAGNAME=		2b9c8f101f0814e6b026d11578713b54641d4430
USE_GITHUB=		nodefaults
GH_TUPLE= \
				Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:edbee_lib/3rdparty/edbee-lib \
				martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:lua_code_formatter/3rdparty/lcf \
				julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:qt_tags_widget/3rdparty/qt-tags-widget \
				getsentry:sentry-native:42ca73a6c7a8f6638db12ef587ef0ac6fe67d21e:sentry_native/3rdparty/sentry-native
# It seems to work with the LIB_DEPENDS for security/qtkeychain@qt6 instead of this version:
#				frankosterfeld:qtkeychain:e3b2e83f01cccadf9257c3143ae6a066b7d02149:qtkeychain/3rdparty/qtkeychain \
# My test item
#				lloyd:yajl:5e3a7856e643b4d6410ddc3f84bc2f38174f2872:yajl/3rdparty/yajl \

#USE_GL=			gl opengl glu
USE_GL=			opengl glu
USE_QT=			base 5compat multimedia tools speech

# USES=cmake related variables ##--------------------------------------------------------------------------
CMAKE_ARGS+=	-DCMAKE_INSTALL_PREFIX="/usr/local" \
				-DCMAKE_AUTORCC=ON \
				-DCMAKE_AUTOMOC=OFF \
				-DCMAKE_AUTOUIC=OFF \
				-DCMAKE_OUTSOURCE=OFF
### Make block ##------------------------------------------------------------------------------------------
CONFIGURE_ENV=	WITH_OWN_QTKEYCHAIN=NO \
				WITH_UPDATER=NO \
				WITH_VARIABLE_SPLASH_SCREEN=NO \
				XDG_DATA_DIRS=/usr/share \
				CFLAGS="$CFLAGS -std=gnu17"
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
	${LOCALBASE}/bin/luarocks54 --tree=${LOCALBASE} --lua-version 5.1 install lua-yajl
	${LOCALBASE}/bin/luarocks54 --tree=${LOCALBASE} --lua-version 5.1 install lpeg
	${LOCALBASE}/bin/luarocks54 --tree=${LOCALBASE} --lua-version 5.1 install luautf8
	${LOCALBASE}/bin/luarocks54 --tree=${LOCALBASE} --lua-version 5.1 install lua-zip
	${LOCALBASE}/bin/luarocks54 --tree=${LOCALBASE} --lua-version 5.1 install lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 --tree=${LOCALBASE} --lua-version 5.1 install luafilesystem
	${LOCALBASE}/bin/luarocks54 --tree=${LOCALBASE} --lua-version 5.1 install luasql-sqlite3

#post-build:
#	@${ECHO_MSG} "==> Forcing translation resource rebuild..."
#	@${RM} -f ${WRKDIR}/.build/translations/translated/*.qm \
#		${WRKDIR}/.build/translations/translated/qm.qrc
#	@${RM} -rf ${WRKDIR}/.build/src/CMakeFiles/mudlet_core.dir \
#		${WRKDIR}/.build/src/libmudlet_core.a
#	@${SETENV} ${CONFIGURE_ENV} ${CMAKE_BIN} -S${WRKSRC} -B${WRKDIR}/.build ${CMAKE_ARGS}
#	@${MAKE_CMD} -C ${WRKDIR}/.build mudlet_core
#	@${MAKE_CMD} -C ${WRKDIR}/.build mudlet

post-stage:
#	@${ECHO_MSG} "==> Installing Mudlet Lua framework (with patches)..."
#	@${MKDIR} ${STAGEDIR}${PREFIX}/share/mudlet/lua
#	@${MKDIR} ${STAGEDIR}${PREFIX}/share/mudlet/lua/geyser
#	@${MKDIR} ${STAGEDIR}${PREFIX}/share/mudlet/translations
# Force copy of all Lua files from the build tree
#	@${CP} -Rp ${WRKDIR}/.build/src/mudlet-lua/lua/* \
#		${STAGEDIR}${PREFIX}/share/mudlet/lua/ 2>/dev/null || true
# Loose .qm files (important fallback)
#	@${CP} -p ${WRKDIR}/.build/translations/translated/*.qm \
#		${STAGEDIR}${PREFIX}/share/mudlet/translations/ 2>/dev/null || true
#	@${ECHO_MSG} "Installed Lua files and translations"
#	@${LS} ${STAGEDIR}${PREFIX}/share/mudlet/lua/Other.lua \
#		${STAGEDIR}${PREFIX}/share/mudlet/lua/geyser/GeyserAdjustableContainer.lua 2>/dev/null || true
#	@${LS} ${STAGEDIR}${PREFIX}/share/mudlet/translations/ | ${HEAD} -10
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lpeg
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luautf8
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-zip
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-yajl
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luafilesystem
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luasql-sqlite3
	${CP} -R ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/* ${LOCALBASE}/lib/lua/5.1/
# The .qm files themselves do NOT go into ${STAGEDIR} (they are embedded)
# Optional: Verify embedding
	@${ECHO_MSG} "Checking embedded translations..."
	@strings ${STAGEDIR}${PREFIX}/bin/mudlet 2>/dev/null | ${GREP} -E ':/lang/mudlet_.*\.qm' \
	|| ${ECHO_MSG} "WARNING: No embedded .qm resources found!"

# It took 8-12 hours of effort with repeated building testing and modifying, with help from Grok to cure the UI problem.

#----------------------------------------------------------------------

.include <bsd.port.mk>

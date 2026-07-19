### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=		Mudlet
DISTVERSION=	g20260716
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

# lua-luarocks option for luajit will break the dependency here.
# dependencies ##------------------------------------------------------------------------------------------
BUILD_DEPENDS= 	luarocks54:devel/lua-luarocks@lua54\
				${LOCALBASE}/lib/lua/5.1/bit.so:devel/lua-bitop@lua51 \
				${LOCALBASE}/share/hunspell/en_US.aff:textproc/en-hunspell \
				${LOCALBASE}/lib/qt6/libQt6UiTools.so:devel/qt6-tools 

LIB_DEPENDS=	libassimp.so:multimedia/assimp \
				libqt6keychain.so:security/qtkeychain \
				libpugixml.so:textproc/pugixml \
				libhunspell-1.7.so:textproc/hunspell \
				libpcre2-8.so:devel/pcre2 \
				libzip.so:archivers/libzip \
				libminizip.so:archivers/minizip \
				libsysinfo.so:devel/libsysinfo \
				liblua-5.1.so:lang/lua51 \
				libyajl.so:devel/yajl

RUN_DEPENDS=	curl:ftp/curl \
				zstd:archivers/zstd \
				${LOCALBASE}/lib/libboost_atomic.so:devel/boost-libs

### uses block ##------------------------------------------------------------------------------------------
USES=			lua:51 cmake:noninja gmake sqlite qt:6 desktop-file-utils gl pkgconfig

USE_GITHUB=		nodefaults
GH_ACCOUNT=		Mudlet
GH_TAGNAME=		2d5789dde35c7675e096f94d6843e291f66c9f66
GH_TUPLE= \
				Mudlet:edbee-lib:a3ae51bbb82158366b3d5c4030a54981db688892:edbee_lib/3rdparty/edbee-lib \
				martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:lua_code_formatter/3rdparty/lcf \
				julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:qt_tags_widget/3rdparty/qt-tags-widget
 
USE_GL=			gl opengl glu
USE_QT=			base 5compat multimedia tools speech

# USES=cmake related variables ##--------------------------------------------------------------------------
CMAKE_ARGS+=	-DCMAKE_INSTALL_PREFIX="${LOCALBASE}" \
				-DQt6Keychain_DIR=${LOCALBASE}/lib/cmake/Qt6Keychain \
				-DCMAKE_AUTORCC=ON \
				-DCMAKE_AUTOMOC=OFF \
				-DCMAKE_AUTOUIC=OFF \
				-DQT_DEBUG_FIND_PACKAGE=ON \
				-DCMAKE_OUTSOURCE=OFF

### Make block ##------------------------------------------------------------------------------------------
#
# conflicts ##-------------------------------------------------------------------------------------------
CONFLICTS=		Mudlet mudlet
#
### wrksrc block ##----------------------------------------------------------------------------------------
#
### packaging list block ##--------------------------------------------------------------------------------
#
### options definitions ##---------------------------------------------------------------------------------
OPTIONS_DEFINE=		SENTRY_DEBUG 3D_MAPPER FONTS MEM_TRACK HOT_RELOAD VAR_SPLASH SENTRY STATIC_ANALYSIS \
					SKIP_INSTALL_RPATH SKIP_RPATH
OPTIONS_DEFAULT=	FONTS 3D_MAPPER VAR_SPLASH

#
### options descriptions ##--------------------------------------------------------------------------------
SENTRY_DEBUG_DESC=			Send debug files to Sentry after build
3D_MAPPER_DESC=				Include optional 3D mapper
FONTS_DESC=					Include optional fonts ${LOCALBASE}/llvm${LLVM_DEFAULT}/bin/clang-tidy
MEM_TRACK_DESC=				Include optional memory tracking
HOT_RELOAD_DESC=			Include optional shader hot-reloading
BUILDTYPE_SPLASH_DESC=		Include optional build-type splash screen
SENTRY_DESC=				Enable crash reporting via Sentry (token needed) *missing subdirs*
STATIC_ANALYSIS_DESC=		Enable static analysis with clang-tidy and cppcheck
SKIP_INSTALL_RPATH_DESC=	runtime paths are not added when installing shared libraries, but are added when building
SKIP_RPATH_DESC=			runtime paths are not added when using shared libraries

#
### options helpers ##-------------------------------------------------------------------------------------
SENTRY_DEBUG_CMAKE_BOOL=				SENTRY_SEND_DEBUG
3D_MAPPER_CMAKE_BOOL=					USE_3DMAPPER
FONTS_CMAKE_BOOL=						USE_FONTS
MEM_TRACK_CMAKE_BOOL=					USE_MEMORY_TRACKING
HOT_RELOAD_CMAKE_BOOL=					USE_SHADER_HOT_RELOAD
BUILDTYPE_SPLASH_CMAKE_BOOL=			USE_VARIABLE_SPLASH_SCREEN
SENTRY_CMAKE_BOOL= 						WITH_SENTRY
STATIC_ANALYSIS_CMAKE_BOOL=				ENABLE_STATIC_ANALYSIS
SKIP_INSTALL_RPATH_CMAKE_BOOL=			CMAKE_SKIP_INSTALL_RPATH
SKIP_RPATH_CMAKE_BOOL=					CMAKE_SKIP_RPATH

SENTRY_DEBUG_IMPLIES=					SENTRY

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MSENTRY}
GH_TUPLE+=getsentry:sentry-native:ae55c1bc2f828da06b4a88f5d6b23a49e3f45a22:sentry_native/3rdparty/sentry-native
.endif

.if ${PORT_OPTIONS:MSTATIC_ANALYSIS}
BUILD_DEPENDS+=	cppcheck:devel/cppcheck
CMAKE_ARGS+= -DCLANG_TIDY_EXE="${LOCALBASE}/llvm${LLVM_DEFAULT}/bin/clang-tidy"
.endif

#
#post-extract:
pre-build:
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lpeg
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luautf8
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-zip
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install lua-yajl
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luafilesystem
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install luasql-sqlite3
	${CP} -R ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/* ${LOCALBASE}/lib/lua/5.1/

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
#
# The .qm files themselves do NOT go into ${STAGEDIR} (they are embedded)
# Optional: Verify embedding
	@${ECHO_MSG} "Checking embedded translations..."
	@strings ${STAGEDIR}${PREFIX}/bin/mudlet 2>/dev/null | ${GREP} -E ':/lang/mudlet_.*\.qm' \
	|| ${ECHO_MSG} "WARNING: No embedded .qm resources found!"

# It took 8-12 hours of effort with repeated building testing and modifying, with help from Grok to cure the UI problem.

#----------------------------------------------------------------------

.include <bsd.port.mk>

### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=	Mudlet
DISTVERSION=	g20260923
CATEGORIES=	games
MASTER_SITES=	GH
PKGNAMESUFFIX=	-dev
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block ##--------------------------------------------------------------------------------------
MAINTAINER=	nope@nothere
COMMENT=	Cross-platform, open source, super fast MUD client with lua scripting
WWW=		https://mudlet.org/

### License block ##---------------------------------------------------------------------------------------
LICENSE=		GPLv2+
LICENSE_FILE=	${WRKSRC}/COPYING

# luajit option for lua-luarocks will break the dependency here.
# dependencies ##------------------------------------------------------------------------------------------
BUILD_DEPENDS= 	git:devel/git \
		luarocks54:devel/lua-luarocks@lua54 \
		${LOCALBASE}/lib/lua/5.1/bit.so:devel/lua-bitop@lua51 \
		${LOCALBASE}/share/hunspell/en_US.aff:textproc/en-hunspell \
		${LOCALBASE}/lib/qt6/libQt6UiTools.so:devel/qt6-tools 

LIB_DEPENDS=	libassimp.so:multimedia/assimp \
		libqt6keychain.so:security/qtkeychain@qt6 \
		libQt6Core5Compat.so:devel/qt6-5compat \
		libQt6Multimedia.so:multimedia/qt6-multimedia \
		libQt6TextToSpeech.so:accessibility/qt6-speech \
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
USES=		lua:51 cmake ninja sqlite qt:6 desktop-file-utils gl pkgconfig gettext-runtime localbase:ldflags

USE_GITHUB=	nodefaults
GH_ACCOUNT=	Mudlet
GH_TAGNAME=	8b6f3a37c2ea3882bdb358890f5c8140d5502732
GH_TUPLE= \
		Mudlet:edbee-lib:9a9155146870af4bba80502f34c446a3a68f42e8:edbee_lib/3rdparty/edbee-lib \
		martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:lua_code_formatter/3rdparty/lcf \
		julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:qt_tags_widget/3rdparty/qt-tags-widget

 
USE_GL=		gl opengl glu
USE_QT=		base 5compat multimedia tools speech
USE_GNOME=	glib20

# USES=cmake related variables ##--------------------------------------------------------------------------
CMAKE_ARGS+=	-DCMAKE_INSTALL_PREFIX="${LOCALBASE}" \
				-DQtKeychain_DIR=${LOCALBASE}/lib/cmake/Qt6Keychain \
				-DQT_DEBUG_FIND_PACKAGE=ON \
				-DCMAKE_BUILD_TYPE=DEBUG \
				-DCMAKE_FIND_DEBUG_MODE=true \
				--debug-output
#				-DCMAKE_OUTSOURCE=OFF
#				-DCMAKE_AUTORCC=ON \
#				-DCMAKE_AUTOMOC=OFF \
#				-DCMAKE_AUTOUIC=ON \
#				-DQt6Keychain_DIR=${LOCALBASE}/lib/cmake/Qt6Keychain \

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
GH_TUPLE+=getsentry:sentry-native:a1827544e2da7e50517615003288c25380f8d457:sentry_native/3rdparty/sentry-native
.endif

.if ${PORT_OPTIONS:MSTATIC_ANALYSIS}
BUILD_DEPENDS+=	cppcheck:devel/cppcheck
CMAKE_ARGS+= -DCLANG_TIDY_EXE="${LOCALBASE}/llvm${LLVM_DEFAULT}/bin/clang-tidy"
.endif

#
#post-extract:
pre-build:
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install gvvaughan/lpeg
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install xavier-wang/luautf8
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install brimworks/lua-zip
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install rrt/lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install brimworks/lua-yajl
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install hisham/luafilesystem
#	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.4 install tomasguisasola/luasql-sqlite3
#	${CP} -R ${STAGEDIR}${LOCALBASE}/lib/lua/5.4/* ${LOCALBASE}/lib/lua/5.4/
	${CP} -R ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/* ${LOCALBASE}/lib/lua/5.1/

post-stage:
	@${ECHO_MSG} "Checking embedded translations..."
	@strings ${STAGEDIR}${PREFIX}/bin/mudlet 2>/dev/null | ${GREP} -E ':/lang/mudlet_.*\.qm' \
	|| ${ECHO_MSG} "WARNING: No embedded .qm resources found!"

#----------------------------------------------------------------------

.include <bsd.port.mk>

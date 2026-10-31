### PORTNAME block ##--------------------------------------------------------------------------------------
PORTNAME=	Mudlet
DISTVERSION=	g20261028
CATEGORIES=	games
MASTER_SITES=	GH
PKGNAMESUFFIX=	-dev
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block ##--------------------------------------------------------------------------------------
MAINTAINER=	nope@nothere
COMMENT=	Cross-platform, open source, super fast MUD client with lua scripting
WWW=		https://mudlet.org/

### License block ##---------------------------------------------------------------------------------------
LICENSE=	GPLv2+
LICENSE_FILE=	${WRKSRC}/COPYING

# luajit option for lua-luarocks will break the dependency here.
# dependencies ##------------------------------------------------------------------------------------------
BUILD_DEPENDS= 	git:devel/git \
		luarocks54:devel/lua-luarocks@lua54 \
		${LOCALBASE}/lib/lua/5.1/bit.so:devel/lua-bitop@lua51 \
		${LOCALBASE}/share/hunspell/en_US.aff:textproc/en-hunspell \
		${LOCALBASE}/lib/qt6/libQt6UiTools.so:devel/qt6-tools
#
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
		libyajl.so:devel/yajl \
		libonig.so:devel/oniguruma \
		libQt6Svg.so:graphics/qt6-svg
#
RUN_DEPENDS=	curl:ftp/curl \
		zstd:archivers/zstd \
		${LOCALBASE}/lib/libboost_atomic.so:devel/boost-libs

### uses block ##------------------------------------------------------------------------------------------
USES=		lua:51 cmake ninja gnome sqlite qt:6 desktop-file-utils gl pkgconfig gettext-runtime localbase:ldflags

USE_GITHUB=	nodefaults
GH_ACCOUNT=	Mudlet
GH_TAGNAME=	718d011fb511b914768a6c4346166e35b57d628c
GH_TUPLE= \
		Mudlet:edbee-lib:64960cdf988e6e758388cfc5fcb5542d845ad4be:edbeelib/3rdparty/edbee-lib \
		martin-eden:lua_code_formatter:4aa25029eae867840e6c06c7b075f4b690dd2ec2:lua_code_formatter/3rdparty/lcf \
		julian-go:qt-tags-widget:26f177cbcebe66fdc3e8daed4d0984a7f60f3431:qttagswidget/3rdparty/qt-tags-widget \
		frankosterfeld:qtkeychain:875f77d9f61bd97fd84cca47ce3bc71186dfbd09:qtkeychain/3rdparty/qtkeychain

USE_GL=		gl opengl glu
USE_GNOME=	glib20
USE_QT=		base 5compat multimedia tools speech svg

# USES=cmake related variables ##--------------------------------------------------------------------------
CMAKE_ARGS+=	-DCMAKE_INSTALL_PREFIX="${LOCALBASE}" \
				-DQtKeychain_DIR=${LOCALBASE}/lib/cmake/Qt6Keychain

# Mudlet CMakeLists.txt has both CMAKE_SKIP_INSTALL_RPATH and CMAKE_SKIP_RPATH but FreeBSD ports system
# handles this properly, do not use either.
#
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
OPTIONS_DEFAULT=		FONTS HOT_RELOAD 3D_MAPPER VAR_SPLASH
OPTIONS_GROUP=			PLAYER OPTION DEVEL
OPTIONS_GROUP_PLAYER=	3D_MAPPER FONTS HOT_RELOAD
OPTIONS_GROUP_DEVEL=		SENTRY SENTRY_DEBUG STATIC_ANALYSIS
OPTIONS_GROUP_OPTION=	VAR_SPLASH

#
### options descriptions ##--------------------------------------------------------------------------------
PLAYER_DESC=	Player needs
OPTION_DESC=			Optional
DEVEL_DESC=			Developer only settings
3D_MAPPER_DESC=			Include optional 3D mapper
DEBUG_DESC=			Set debug build type, cmake and qt debug verbosity
FONTS_DESC=			Include optional fonts
HOT_RELOAD_DESC=		Include optional shader hot-reloading
MEM_TRACK_DESC=			Include optional memory tracking / introspection (experimental)
SENTRY_DEBUG_DESC=		Send debug files to Sentry after build (requires SENTRY_AUTH_TOKEN)
SENTRY_DESC=			Enable crash reporting via Sentry (requires SENTRY_DSN)
STATIC_ANALYSIS_DESC=		Enable static analysis with clang-tidy and cppcheck *VERY SLOW / LONG*
VAR_SPLASH_DESC=		Include build-type splash screen

#
### options helpers ##-------------------------------------------------------------------------------------
3D_MAPPER_CMAKE_BOOL=		USE_3DMAPPER
DEBUG_CMAKE_ON=			-DCMAKE_BUILD_TYPE="DEBUG" \
				-DCMAKE_FIND_DEBUG_MODE=true \
				-DQT_DEBUG_FIND_PACKAGE=ON \
				--debug-output
DEBUG_CMAKE_OFF=		-DCMAKE_BUILD_TYPE="Release"
FONTS_CMAKE_BOOL=		USE_FONTS
HOT_RELOAD_CMAKE_BOOL=		USE_SHADER_HOT_RELOAD
MEM_TRACK_CMAKE_BOOL=		USE_MEMORY_TRACKING
SENTRY_CMAKE_BOOL= 		WITH_SENTRY
SENTRY_DEBUG_IMPLIES=		SENTRY
SENTRY_DEBUG_CMAKE_BOOL=	SENTRY_SEND_DEBUG
STATIC_ANALYSIS_CMAKE_BOOL=	ENABLE_STATIC_ANALYSIS
VAR_SPLASH_CMAKE_BOOL=		USE_VARIABLE_SPLASH_SCREEN

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MSENTRY}
GH_TUPLE+=	getsentry:sentry-native:740313523edd50e3a0cfe2f8f931e893ed7423a5:sentrynative/3rdparty/sentry-native \
		google:benchmark:48f5cc2:benchmark/3rdparty/sentry-native/external/benchmark \
		getsentry:breakpad:25b6b72:breakpad/3rdparty/sentry-native/external/breakpad \
		getsentry:crashpad:493151b:crashpad/3rdparty/sentry-native/external/crashpad \
		getsentry:chromium-linux-syscall-support:9719c1e1:chromiumlinuxsyscallsupport/3rdparty/sentry-native/external/crashpad/third_party/lss/lss \
		getsentry:mini_chromium:2f5c168f:mini_chromium/3rdparty/sentry-native/external/crashpad/third_party/mini_chromium/mini_chromium \
		getsentry:chromium-zlib:fef58692:chromiumzlib/3rdparty/sentry-native/external/crashpad/third_party/zlib/zlib \
		getsentry:libunwindstack-ndk:284202f:libunwindstackndk/3rdparty/sentry-native/external/libunwindstack-ndk \
		getsentry:chromium-linux-syscall-support:ed31caa:chromiumlinuxsyscallsupport/3rdparty/sentry-native/external/third_party/lss
.endif

# Pass SENTRY_DSN to CMake when it is provided (environment or make command line)
.if defined(SENTRY_DSN) && !empty(SENTRY_DSN)
CMAKE_ARGS+=	-DSENTRY_DSN:STRING="${SENTRY_DSN}"
.endif

# SENTRY_AUTH_TOKEN is used as an environment variable by the post-build upload script;
# just make sure it is available when SENTRY_DEBUG is on.
.if ${PORT_OPTIONS:MSENTRY_DEBUG}
.  if defined(SENTRY_AUTH_TOKEN) && !empty(SENTRY_AUTH_TOKEN)
MAKE_ENV+=	SENTRY_AUTH_TOKEN="${SENTRY_AUTH_TOKEN}"
.  endif
.endif

.if ${PORT_OPTIONS:MSTATIC_ANALYSIS}
BUILD_DEPENDS+=	cppcheck:devel/cppcheck
CMAKE_ARGS+= -DCLANG_TIDY_EXE="${LOCALBASE}/llvm${LLVM_DEFAULT}/bin/clang-tidy"
.endif

#--------------------------------------------------------------------
# Maintainer helpers (unofficial -dev convenience)
#--------------------------------------------------------------------
# Print suggested GH_TUPLE for the currently pinned GH_TAGNAME
x-update-tuples:
	@${ECHO_MSG} "NOTE: submodules2tuple -b expects a branch/tag, not a raw commit."
	@${ECHO_MSG} "For GH_TAGNAME=${GH_TAGNAME} use:  make x-list-submodule-shas"
	@${ECHO_MSG} "Or run: submodules2tuple -v -b development https://github.com/${GH_ACCOUNT}/${GH_PROJECT}.git"
	@if ! command -v submodules2tuple >/dev/null 2>&1; then \
		${ECHO_MSG} "Install: pkg install ports-mgmt/submodules2tuple"; exit 1; \
	fi
	@submodules2tuple -v -b development \
		https://github.com/${GH_ACCOUNT}/${GH_PROJECT}.git

# List submodule paths + SHAs at GH_TAGNAME via GitHub API (no full recursive clone)
x-list-submodule-shas:
	@${FETCH_CMD} -qo - \
	"https://api.github.com/repos/${GH_ACCOUNT}/${GH_PROJECT}/git/trees/${GH_TAGNAME}?recursive=1" \
	| jq -r '.tree[] | select(.mode=="160000") | "\(.path)\t\(.sha)"'

# Quick reminder of how to bump
x-bump-help:
	@${ECHO_MSG} "1. Set GH_TAGNAME=<new-commit>"
	@${ECHO_MSG} "2. make x-update-tuples   # or x-list-submodule-shas"
	@${ECHO_MSG} "3. Update GH_TUPLE hashes above"
	@${ECHO_MSG} "4. make makesum"
	@${ECHO_MSG} "5. make check-plist / test build"

#
#post-extract:
pre-build:
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install gvvaughan/lpeg
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install xavier-wang/luautf8
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install brimworks/lua-zip
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install rrt/lrexlib-pcre2
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install brimworks/lua-yajl
	${LOCALBASE}/bin/luarocks54 --tree=${STAGEDIR}${LOCALBASE} --lua-version 5.1 install hisham/luafilesystem
	${CP} -R ${STAGEDIR}${LOCALBASE}/lib/lua/5.1/* ${LOCALBASE}/lib/lua/5.1/

post-stage:
	@${ECHO_MSG} "Checking embedded translations..."
	@strings ${STAGEDIR}${PREFIX}/bin/mudlet 2>/dev/null | ${GREP} -E ':/lang/mudlet_.*\.qm' \
	|| ${ECHO_MSG} "WARNING: No embedded .qm resources found!"

#----------------------------------------------------------------------

.include <bsd.port.mk>

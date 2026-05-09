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
#LICENSE_FILE=	${WRKSRC}/COPYING

# dependencies ##------------------------------------------------------------------------------------------
#LIB_DEPENDS=	libzstd.so:archivers/zstd \
#				libfreetype.so:print/freetype2

### uses block ##------------------------------------------------------------------------------------------
USES=			cmake:noninja gmake lua sqlite  qt:6
USE_LUA=		luarocks
USE_GITHUB=		nodefaults
GH_ACCOUNT=		mudlet
GH_PROJECT=		mudlet
GH_TAGNAME=		4e32ebc58d0abc58418f03145ef54b3b7b7093f8

# USES=cmake related variables ##--------------------------------------------------------------------------
#CMAKE_ARGS=		-DCMAKE_BUILD_TYPE="MinSizeRel" \
#				-DCUSTOM_EXAMPLE_CONF_DIR="${PREFIX}/etc"
#				-DCMAKE_CXX_FLAGS="-stdlib=libc++"
#				-DCMAKE_FETCHCONTENT_FULLY_DISCONNECTED="FALSE"

### Make block ##------------------------------------------------------------------------------------------
#TEST_ENV=		${MAKE_ENV} LC_ALL=C.UTF-8
### conflicts ##-------------------------------------------------------------------------------------------
#CONFLICTS=		luanti minetest irrlichtMt minetest-dev irrlicht-minetest
### wrksrc block ##----------------------------------------------------------------------------------------
WRKSRC=			${WRKDIR}/${PORTNAME}-${GH_TAGNAME}
### packaging list block ##--------------------------------------------------------------------------------
#
### options definitions ##---------------------------------------------------------------------------------
#OPTIONS_DEFAULT=			CURL DOCS LTO OPENSSLCRYPTO SOUND SPATIAL SYSTEM_LUAJIT SYSTEM_GMP SYSTEM_JSONCPP CLIENT OPENGL
#OPTIONS_GROUP=				BUILD DATABASE MISC NEEDS SYSTEM
#OPTIONS_GROUP_BUILD=		BENCHMARKS DEVTEST DOCS NCURSES PROFILING PROMETHEUS UNITTESTS #TRACY GITTRACY
#OPTIONS_GROUP_DATABASE=		LEVELDB PGSQL REDIS
#OPTIONS_GROUP_MISC=			LTO OPENSSLCRYPTO
#OPTIONS_GROUP_NEEDS=		CURL NLS SDL3 SOUND SPATIAL
#OPTIONS_GROUP_SYSTEM=		SYSTEM_GMP SYSTEM_JSONCPP SYSTEM_LUAJIT
#OPTIONS_MULTI=				SOFTWARE
#OPTIONS_MULTI_SOFTWARE=		CLIENT SERVER
#OPTIONS_SINGLE=				GRAPHICS
#OPTIONS_SINGLE_GRAPHICS=	GLES2 OPENGL OPENGL3
#OPTIONS_SUB=				yes
### options descriptions ##--------------------------------------------------------------------------------
#BENCHMARKS_DESC=			Build benchmarks (Adds some benchmark chat commands)
#BUILD_DESC=					Admin/Dev needs
#CLIENT_DESC=				Build client, add graphics and sdl2 support, dependencies
#CURL_DESC=					Enable cURL support for fetching media: contentdb
#DATABASE_DESC=				Database support
#DEVTEST_DESC=				Install Development Test game also (INSTALL_DEVTEST)
#DOCS_DESC=					Build and install documentation (via doxygen)
#GLES2_DESC=					Enable OpenGL ES 2+ driver
#GRAPHICS_DESC=				Graphics support
#LEVELDB_DESC=				Enable LevelDB backend --broken: leveldb port build fails--
#LTO_DESC=					Build with IPO/LTO optimizations (smaller and more efficient than regular build)
#MISC_DESC=					Other options
#NCURSES_DESC=				Enables server side terminal (cli option: --terminal) (ENABLE_CURSES)
#NEEDS_DESC=					Client essentials
#NLS_DESC=					Native Language Support (ENABLE_GETTEXT)
#OPENGL3_DESC=				Enable OpenGL 3+ driver
#OPENGL_DESC=				Enable OpenGL driver
#OPENSSLCRYPTO_DESC=			Enable openssl libcrypto (faster SHA1 and SHA2 hashing)
#PGSQL_DESC=					Enable PostgreSQL map backend
#PROFILING_DESC=				Use gprof for profiling (USE_GPROF)
#PROMETHEUS_DESC=			Build with Prometheus metrics exporter
#REDIS_DESC=					Enable Redis backend
#SDL3_DESC=					Use SDL3 instead of default SDL2
#SERVER_DESC=				Build server
#SOFTWARE_DESC=				Software components
#SOUND_DESC=					Enable sound via openal-soft
#SPATIAL_DESC=				Enable SpatialIndex (Speeds up AreaStores)
#SYSTEM_DESC=				System subsitutes
#SYSTEM_GMP_DESC=			Use gmp from ports (ENABLE_SYSTEM_GMP)
#SYSTEM_JSONCPP_DESC=		Use jsoncpp from ports (ENABLE_SYSTEM_JSONCPP)
#SYSTEM_LUAJIT_DESC=			Use or install luajit from ports (instead of bundled lua)
#UNITTESTS_DESC=				Build unit test sources (BUILD_UNITTESTS)

### options helpers ##-------------------------------------------------------------------------------------
#BENCHMARKS_CMAKE_BOOL=		BUILD_BENCHMARKS
#CLIENT_LIB_DEPENDS=			libpng16.so:graphics/png
#CLIENT_USES=				gl xorg jpeg
#CLIENT_USE=	\
#							GL=glu \
#							SDL=sdl2,ttf2 \
#							XORG=ice,sm,x11,xext,xcb,xres,xshmfence,xau,xaw,xcomposite,xcursor,xdamage,xdmcp,\
#							xfixes,xft,xinerama,xkbfile,xmu,xpm,xrandr,xrender,xscreensaver,xt,xtst,xv,xxf86vm
#
#CLIENT_CMAKE_BOOL=			BUILD_CLIENT
#CURL_LIB_DEPENDS=			libcurl.so:ftp/curl
#CURL_CMAKE_BOOL=			ENABLE_CURL
#DEVTEST_CMAKE_BOOL=			INSTALL_DEVTEST
#DOCS_CMAKE_BOOL=			BUILD_DOCUMENTATION
#GLES2_USE=					GL+=glesv2
#GLES2_CMAKE_BOOL=			ENABLE_GLES2
#LEVELDB_LIB_DEPENDS=		libleveldb.so:databases/leveldb
#LEVELDB_CMAKE_BOOL=			ENABLE_LEVELDB
#LTO_CMAKE_BOOL=				ENABLE_LTO
#NCURSES_USES=				ncurses
#NCURSES_CMAKE_BOOL=			ENABLE_CURSES
#NLS_USES=					gettext
#NLS_CMAKE_BOOL=				ENABLE_GETTEXT
#NLS_LDFLAGS=				-L${LOCALBASE}/lib
#OPENGL3_USE=				GL+=gl
#OPENGL3_CMAKE_BOOL=			ENABLE_OPENGL3
#OPENGL_USE=					GL+=gl
#OPENGL_CMAKE_BOOL=			ENABLE_OPENGL
#OPENSSLCRYPTO_USES=			ssl
#OPENSSLCRYPTO_CMAKE_BOOL=	ENABLE_OPENSSL
#PGSQL_USES=					pgsql
#PGSQL_CMAKE_BOOL=			ENABLE_POSTGRESQL
#PROFILING_CMAKE_BOOL=		USE_GPROF
#PROMETHEUS_CMAKE_BOOL=		ENABLE_PROMETHEUS
#REDIS_LIB_DEPENDS=			libhiredis.so:databases/hiredis
#REDIS_CMAKE_BOOL=			ENABLE_REDIS
#SDL3_CMAKE_BOOL=			USE_SDL3
#SDL3_LIB_DEPENDS=			libSDL3.so:devel/sdl3
#SERVER_CMAKE_BOOL=			BUILD_SERVER
#SOUND_CMAKE_BOOL=			ENABLE_SOUND
#SPATIAL_LIB_DEPENDS=		libspatialindex.so:devel/spatialindex
#SPATIAL_CMAKE_BOOL=			ENABLE_SPATIAL
#SYSTEM_GMP_LIB_DEPENDS=		libgmp.so:math/gmp
#SYSTEM_GMP_CMAKE_BOOL=		ENABLE_SYSTEM_GMP
#SYSTEM_GMP_CMAKE_ON=		-DGMP_INCLUDE_DIR="${PREFIX}/include"
#SYSTEM_JSONCPP_LIB_DEPENDS=	libjsoncpp.so:devel/jsoncpp
#SYSTEM_JSONCPP_CMAKE_BOOL=	ENABLE_SYSTEM_JSONCPP
#SYSTEM_JSONCPP_CMAKE_ON=	-DJSON_INCLUDE_DIR="${PREFIX}/include/jsoncpp"
#SYSTEM_LUAJIT_USES=			luajit
#SYSTEM_LUAJIT_USE=			luajit
#SYSTEM_LUAJIT_CMAKE_BOOL=	ENABLE_LUAJIT # Redundant as one of the above includes this
#UNITTESTS_CMAKE_BOOL=		BUILD_UNITTESTS

.include <bsd.port.options.mk>

#.if ${PORT_OPTIONS:MCLIENT} && ${PORT_OPTIONS:MSYSTEM_LUAJIT}
#CMAKE_ARGS+=	-DENABLE_LUAJIT="ON" \
#				-DREQUIRE_LUAJIT="ON"
#.endif

#.if ${PORT_OPTIONS:MCLIENT} && ${PORT_OPTIONS:MOPENGL}
#USE_GL+=		glu opengl
#USE_XORG+=		xi
#.endif

#.if ${PORT_OPTIONS:MCLIENT}
#USE_GL+=		gl
#.endif

#.if ${PORT_OPTIONS:MCLIENT} && ${PORT_OPTIONS:MSOUND}
#USES+=			openal
#LIB_DEPENDS+=	libogg.so:audio/libogg libvorbisfile.so:audio/libvorbis
#.endif

#.if ${PORT_OPTIONS:MCLIENT} && !${PORT_OPTIONS:MSDL3}
#SDL=sdl2,ttf2
#.endif

#.if ${PORT_OPTIONS:MCLIENT} && ${PORT_OPTIONS:MSDL3}
#SDL=sdl3,ttf
#.endif

# In addition to below, `make check-plist` wants the %%SERVER%% omitted from the etc/rc.d/luanti line
# but if I do not set the config to build the server then it fails to find etc/rc.d/luanti to install,
# so it is best to include the %%SERVER%% and ignore what check-plist wants.
#.if ${PORT_OPTIONS:MSERVER}
#USE_RC_SUBR=	${PORTNAME}
# When the official /usr/ports/GIDs file is changed, this may be luanti instead of minetest.
# At that time the files/luanti.in will need to be modified for the user and group defined.
#USERS=			minetest #USERS=			${PORTNAME}
#GROUPS=			minetest #GROUPS=		${PORTNAME}
#.endif

#do-test-UNITTESTS-on:
#.if ${PORT_OPTIONS:MCLIENT}
#	cd ${WRKDIR} && ${SETENV} ${TEST_ENV} ${STAGEDIR}${PREFIX}/bin/luanti --run-unittests
#.endif
#.if ${PORT_OPTIONS:MSERVER}
#	cd ${WRKDIR} && ${SETENV} ${TEST_ENV} ${STAGEDIR}${PREFIX}/bin/luantiserver --run-unittests
#.endif

# It turns out that hard links or relative links do not work for luanti and ordinary symbolic links fail to work as desired.
#post-stage:
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-Bold.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-BoldItalic.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-Italic.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-Regular.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-LICENSE.txt
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-Bold.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-BoldItalic.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-Italic.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-LICENSE.txt
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-Regular.ttf
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/DroidSansFallbackFull-LICENSE.txt
#	${RM} ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/DroidSansFallbackFull.ttf
#
#	${LN} -L ${LOCALBASE}/share/fonts/ChromeOS/Arimo-Bold.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-Bold.ttf
#	${LN} -L ${LOCALBASE}/share/fonts/ChromeOS/Arimo-BoldItalic.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-BoldItalic.ttf
#	${LN} -L ${LOCALBASE}/share/fonts/ChromeOS/Arimo-Italic.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Arimo-Italic.ttf
#	${LN} -L ${LOCALBASE}/share/fonts/ChromeOS/Cousine-Bold.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-Bold.ttf
#	${LN} -L ${LOCALBASE}/share/fonts/ChromeOS/Cousine-BoldItalic.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-BoldItalic.ttf
#	${LN} -L ${LOCALBASE}/share/fonts/ChromeOS/Cousine-Italic.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-Italic.ttf
#	${LN} -L ${LOCALBASE}/share/fonts/ChromeOS/Cousine-Regular.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/Cousine-Regular.ttf
#	${LN} -L ${LOCALBASE}/share/fonts/Droid/DroidSansFallbackFull.ttf ${STAGEDIR}${LOCALBASE}/share/luanti/fonts/DroidSansFallbackFull.ttf
#

# These are temporary links which might only be useful for transition and a blind update, when used they indicate a deprecated solution.
#	${RM} ${STAGEDIR}${LOCALBASE}/bin/minetest
#	${RM} ${STAGEDIR}${LOCALBASE}/bin/minetestserver

#----------------------------------------------------------------------
#CMake Warning:
#  Manually-specified variables were not used by the project:
#
#    CMAKE_MODULE_LINKER_FLAGS
#    CMAKE_SHARED_LINKER_FLAGS
#    CMAKE_VERBOSE_MAKEFILE
#    FETCHCONTENT_FULLY_DISCONNECTED
#    ICONV_INCLUDE_DIR
#    ICONV_LIBRARIES
#    LIBICONV_INCLUDE_DIR
#    LIBICONV_LIBRARIES
#    LIBICONV_LIBRARY
#----------------------------------------------------------------------

.include <bsd.port.mk>

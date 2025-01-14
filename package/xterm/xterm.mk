################################################################################
#
# xterm
#
################################################################################
# batocera - bump
XTERM_VERSION = 388
XTERM_SOURCE = xterm-$(XTERM_VERSION).tgz
XTERM_SITE = http://invisible-mirror.net/archives/xterm
XTERM_DEPENDENCIES = ncurses xlib_libXaw host-pkgconf
XTERM_LICENSE = MIT
XTERM_LICENSE_FILES = COPYING
XTERM_CPE_ID_VENDOR = invisible-island
XTERM_CONF_OPTS = --enable-256-color \
	--x-includes=$(STAGING_DIR)/usr/include \
	--x-libraries=$(STAGING_DIR)/usr/lib

# Avoid freetype2 path poisoning by imake
# batocera - add -ltinfo
XTERM_CONF_ENV = ac_cv_path_IMAKE="" LIBS="-ltinfo"

ifeq ($(BR2_PACKAGE_XLIB_LIBXFT),y)
XTERM_DEPENDENCIES += xlib_libXft
XTERM_CONF_OPTS += --enable-freetype \
	--with-freetype-config=auto
else
XTERM_CONF_OPTS += --disable-freetype
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXINERAMA),y)
XTERM_DEPENDENCIES += xlib_libXinerama
XTERM_CONF_OPTS += --with-xinerama
else
XTERM_CONF_OPTS += --without-xinerama
endif

$(eval $(autotools-package))

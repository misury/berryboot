################################################################################
#
# libsigrok
#
################################################################################

LIBSIGROK_VERSION = 8656a71790133d4de42252a1e75b4209c03b4983
# No https access on upstream git
LIBSIGROK_SITE = git://sigrok.org/libsigrok
LIBSIGROK_LICENSE = GPLv3+
LIBSIGROK_LICENSE_FILES = COPYING
# Git checkout has no configure script
LIBSIGROK_AUTORECONF = YES
LIBSIGROK_INSTALL_STAGING = YES
LIBSIGROK_DEPENDENCIES = libglib2 libzip host-pkgconf
LIBSIGROK_CONF_OPTS = --disable-libudev --disable-bindings --disable-glibtest

define LIBSIGROK_ADD_MISSING
	mkdir -p $(@D)/autostuff
endef

LIBSIGROK_PRE_CONFIGURE_HOOKS += LIBSIGROK_ADD_MISSING

ifeq ($(BR2_PACKAGE_LIBFTDI),y)
LIBSIGROK_CONF_OPTS += --enable-libftdi
LIBSIGROK_DEPENDENCIES += libftdi
else
LIBSIGROK_CONF_OPTS += --disable-libftdi
endif

ifeq ($(BR2_PACKAGE_LIBUSB),y)
LIBSIGROK_CONF_OPTS += --enable-libusb
LIBSIGROK_DEPENDENCIES += libusb
else
LIBSIGROK_CONF_OPTS += --disable-libusb
endif

ifeq ($(BR2_PACKAGE_GLIBMM),y)
LIBSIGROK_DEPENDENCIES += glibmm
endif

$(eval $(autotools-package))

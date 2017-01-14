

include $(THEOS)/makefiles/common.mk

GO_EASY_ON_ME=1

TWEAK_NAME = Photicon

$(TWEAK_NAME)_FILES = Tweak.xmi

$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = PhotoLibraryServices

$(TWEAK_NAME)_LDFLAGS += -F/opt/theos/sdks/iPhoneOS9.3.sdk/System/Library/PrivateFrameworks/

#   THEOS BUILD WITH XMI NEEDS SOME HELP

$(TWEAK_NAME)_CFLAGS += -D THEOSBUILD=1 -D HBLogError=NSLog -w

Tweak.xmi_LDFLAGS += -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += preferences
include $(THEOS_MAKE_PATH)/aggregate.mk

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Photicon
Photicon_FILES = PHPRootListController.m CRPSTableViewCell.m PHPAlbumPickerViewController.m
Photicon_INSTALL_PATH = /Library/PreferenceBundles
Photicon_FRAMEWORKS = UIKit
Photicon_PRIVATE_FRAMEWORKS = Preferences PhotoLibraryServices

PHPAlbumPickerViewController.m_LDFLAGS += -fobjc-arc
CRPSTableViewCell.m_LDFLAGS += -fobjc-arc
PHPRootListController.m_CFLAGS += -D THEOSBUILD=1

Photicon_LDFLAGS = -F/opt/theos/sdks/iPhoneOS9.3.sdk/System/Library/PrivateFrameworks/

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Photicon.plist$(ECHO_END)

TARGET := iphone:clang:16.5:15.0


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TGExtra

TGExtra_FILES = $(shell find Sources \( -name '*.swift' -o -name '*.m' -o -name '*.x'\))

TGExtra_SWIFTFLAGS = -I./Sources/tgapiC/include
TGExtra_CFLAGS = -fobjc-arc -I./Sources/tgapiC/include -Wno-deprecated-declarations
TGExtra_FRAMEWORKS = CoreServices
TGExtra_LOGOS_DEFAULT_GENERATOR = internal

TGExtra_RESOURCE_FILES = Sources/tgapi/Resources

# Copy TGExtra.bundle manually during the packaging step
after-stage::
	@echo ">>> Copying Choco.bundle into .deb package..."
	@mkdir -p $(THEOS_STAGING_DIR)/Library/Application\ Support
	@cp -a TGExtra.bundle $(THEOS_STAGING_DIR)/Library/Application\ Support/
	
include $(THEOS_MAKE_PATH)/tweak.mk
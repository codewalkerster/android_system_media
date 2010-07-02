# Build the unit tests.
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

test_src_files := \
    mimeUri_test.cpp \

shared_libraries := \
    libstlport \
    libutils \
    libOpenSLES

static_libraries := \
    libgtest \
    libgtest_main

c_includes := \
    bionic \
    bionic/libstdc++/include \
    external/gtest/include \
    external/stlport/stlport \
    $(JNI_H_INCLUDE) \
    $(TOP)/system/media/opensles/include

module_tags := tests

# We have to use the android version of libdl when we are not on the simulator
ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl libstlport
include external/stlport/libstlport.mk
endif

$(foreach file,$(test_src_files), \
    $(eval include $(CLEAR_VARS)) \
    $(eval LOCAL_SHARED_LIBRARIES := $(shared_libraries)) \
    $(eval LOCAL_STATIC_LIBRARIES := $(static_libraries)) \
    $(eval LOCAL_C_INCLUDES := $(c_includes)) \
    $(eval LOCAL_SRC_FILES := $(file)) \
    $(eval LOCAL_MODULE := libopenslestests) \
    $(eval LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/nativetest) \
    $(eval LOCAL_MODULE_TAGS := $(module_tags)) \
    $(eval include $(BUILD_EXECUTABLE)) \
)

# Build the manual test programs.
include $(call all-subdir-makefiles)
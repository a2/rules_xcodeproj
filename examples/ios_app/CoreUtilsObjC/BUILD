objc_library(
    name = "CoreUtilsObjC",
    srcs = glob(
        ["**/*.m"],
        # Headers included here on purpose, to test `hdrs` collection logic
        ["**/*.h"],
    ),
    hdrs = glob(["**/*.h"]),
    includes = [""],
    module_name = "CoreUtils",
    tags = ["manual"],
    visibility = ["//visibility:public"],
    deps = [
        "//third_party:ExampleFramework",
        "@examples_ios_app_external//:ExternalFramework",
    ],
)

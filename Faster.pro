# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.itor.Faster
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "A9D315A920C9B969C3F48BC976799CC0131280414317733230AAC0327518A8F1D1E9E3C3139A1E810E0FA99ED26C8723FE76B7A2A4B576FE52FEDC1E8B87E4B4A89C4E6C05675B028A9646DFF6A03E807C0F50B2E142668D81B3419A1CEAC6DE9FD3103B5742DC348F5602E9798CDD8B3214FEBEAB308026AAF85A5039B0E515F79BA2CB47DC03A0AE53CDB858A79FE62E7C86CC8B1D61955561C092255AA6EE8469DB6125647C54FB0461BA7DB047FFE5886059BEB06A4FAE0B2F7DCF3BF38DC31B786419F6B3522F87085505C0BFA9ECD292DFA854A94A985273D1B472FEE406638B927DD50B1900C883B34D773F229B5BECD307F7CBA6F8FA5C05E5ADDFD5614B6FF05E93F9FD93DC3E5741E069690535918498681A2C762B75BD5C35C6FF0D3DB60B8AEFDABEED32F92F555218958E1F80837D9C71C74B9C88D34FF569A0"

qmlFolder.source = qml
#DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

FELGO_PLUGINS += admob

CONFIG -= qtquickcompiler

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    qml/scenes/GameScene.qml \
    qml/common/Ground.qml \
    qml/scenes/ShopScene.qml \
    qml/game/Level.qml \
    qml/common/Platform.qml \
    qml/game/GroundCollision.qml \
    qml/entities/BorderElement.qml \
    qml/game/BreakScreen.qml \
    qml/common/BreakButton.qml \
    qml/game/LockedElement.qml \
    qml/scenes/MenuBreak.qml \
    qml/entities/Spike.qml \
    qml/scenes/MenuGameOver.qml \
    qml/common/ImageRadioButton.qml \
    qml/common/Background2.qml \
    qml/game/AudioManager.qml

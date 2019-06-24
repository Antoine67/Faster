import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
  id: window
  screenWidth: 640
  screenHeight: 960

  licenseKey: "A9D315A920C9B969C3F48BC976799CC0131280414317733230AAC0327518A8F1D1E9E3C3139A1E810E0FA99ED26C8723FE76B7A2A4B576FE52FEDC1E8B87E4B4A89C4E6C05675B028A9646DFF6A03E807C0F50B2E142668D81B3419A1CEAC6DE9FD3103B5742DC348F5602E9798CDD8B3214FEBEAB308026AAF85A5039B0E515F79BA2CB47DC03A0AE53CDB858A79FE62E7C86CC8B1D61955561C092255AA6EE8469DB6125647C54FB0461BA7DB047FFE5886059BEB06A4FAE0B2F7DCF3BF38DC31B786419F6B3522F87085505C0BFA9ECD292DFA854A94A985273D1B472FEE406638B927DD50B1900C883B34D773F229B5BECD307F7CBA6F8FA5C05E5ADDFD5614B6FF05E93F9FD93DC3E5741E069690535918498681A2C762B75BD5C35C6FF0D3DB60B8AEFDABEED32F92F555218958E1F80837D9C71C74B9C88D34FF569A0"
  property alias window: window

  activeScene: splash

  // Show loading screen (splash)
  Component.onCompleted: {
    splash.opacity = 1
    if ( !storage.getValue("bestScore") ) storage.setValue("bestScore", 0)
    if ( !storage.getValue("playerSkin") ) storage.setValue("playerSkin", "ballon")
    if ( !storage.getValue("enemySkin") ) storage.setValue("enemySkin", "bird")
    console.log("cst font",customFont)
    mainItemDelay.start()
  }

  property alias customFont: customFont
  FontLoader {
    id: customFont
    onStatusChanged: console.log(state)
    source: "../assets/fonts/Avara.ttf"

    Component.onCompleted: {
      // Explicitly set the font name on Android
      if (system.platform === System.Android)
        customFont.name = "Avara"
    }
  }

  Storage {
      id: storage
  }

  // since the splash has a fade in animation, we delay the loading of the game until the splash is fully displayed for sure
  Timer {
    id: mainItemDelay
    interval: 500
    onTriggered: {
      mainItemLoader.source = "MainItem.qml"
    }
  }

  // as soon as we set the source property, the loader will load the game
  Loader {
    id: mainItemLoader
    onLoaded: {
      if(item) {
        hideSplashDelay.start()
      }
    }
  }

  // give the game a little time to fully display before hiding the splash, just to be sure it looks smooth also on low-end devices
  Timer {
    id: hideSplashDelay
    interval: 200
    onTriggered: {
      splash.opacity = 0
    }
  }

  SplashScene {
    id: splash
  }
}

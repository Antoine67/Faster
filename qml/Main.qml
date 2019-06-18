import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
  id: window
  screenWidth: 640
  screenHeight: 960

  licenseKey: "C41E8E2AC71C2B6F3F4BDBDBCCB16D63A01C55E330483FB841CF1848ACEFCAC6D68A7C25023DDDB9F3DD56AA9D505879E68BA3BE0701679694A043AEBB5327909B03D3887145398C4EFB2755451D8D2F70B57BA45B3035DC9933B390C2C8086849C6300814B252FF31EEE75C85452B388D124AF8CA8EBD6300CEA685878CB2822F817DCF4A514A4E1CD74DF52299B87154A8C527E381DB8910B65EC70A987BC22A6A2BEC916065C2422473D399E319DFE5D8B284AABBAC75911616D79E092CC11B457FF71C7FB76BA393C26D3683EC9936683C6DB991B8B9DCCB742304709274AA2E750E02FF97FB9DF36A064E0E458EB9E2D92F06C0A389FF2B251BC3C2B19479C386F5F2CDE1B34099D792A2D9022582E4CFC35461AC7692598E106838B9DDA2B11F888CA34605C651673EE8D414B80E5D9D630BE0923BE8E0864FA0543651"
  property alias window: window

  activeScene: splash

  // Show loading screen (splash)
  Component.onCompleted: {
    splash.opacity = 1
    mainItemDelay.start()
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

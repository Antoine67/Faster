import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
  id: window
  screenWidth: 640
  screenHeight: 960

  licenseKey: "56E0E3E94CB87C3589A13672627B7DD12FC55DF3F63EDC7B90041A3BDE2F88D688BA0490EDDC1BF9DFE5357B08C4BD9E5470FCEFBD6FFCFA2C7E326C34F4CCFD40C5197F26DDCC80B3BA0E9F61F2DE3D6EBFC18114024434435BE8D15E00DE124199BF732AC04CA94C3FEA72BA089D9C9DD6E39A386A9A01A34C32839D391BECCBD643BA54522307B6AD32E66BB5FEA31087A7640227746EF412E5A7ADC2DB1321412BFB8BA8BD8AC50ED79803FFB40658A62BDDC1875C96990D0A59B70D7AD43DF89013602FC9D6EA1A1880994DDEB4289E717FAA29C22B9CDC46C21931D7326F98D4A88D278178379AA30673440993F8071790F5AFF0AAF25E4AC9628CC5C886D9D163405E24B378FC7DF8C86B439A358849D5B22BD43189A21ADCA180F25F6B989737B8F41FFEB809BD84A8636AB6CFE0F3A32A056EC00E694511A5FEE525"

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

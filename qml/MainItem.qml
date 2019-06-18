import Felgo 3.0
import QtQuick 2.0
import "scenes"



Item {
  id: mainItem
  //property alias audioManager: audioManager
  property alias entityManager: entityManager
  //property alias gameNetwork: vplayGameNetworkScene.gameNetwork

  // for easier reference from GameOverScreen
  //property int highscore: gameNetwork.userHighscoreForCurrentActiveLeaderboard
  property int coins

  // global music and sound management
  /*AudioManager {
    id: audioManager
  }*/

  MenuScene {
    id: menuScene
    onGamePressed: {
        mainItem.state = "game"
        console.log("game pressed")
    }
    onShopPressed: {
        mainItem.state = "shop"
        console.log("shop pressed")
    }

    onBackButtonPressed: {
      nativeUtils.displayMessageBox("Really quit the game?", "", 2);
    }

    /*Connections {
      // nativeUtils should only be connected, when this is the active scene
      target: window.activeScene === menuScene ? nativeUtils : null
      onMessageBoxFinished: {
        if(accepted) {
            Qt.quit()
        }
      }
    }*/
  }

  GameScene {
    id: gameScene

    onMenuPressed: {
      mainItem.state = "menu"
    }
    onShopPressed: {
      mainItem.state = "shop"
    }
  }

  ShopScene {
      id: shopScene

      onBackButtonPressed: {
        mainItem.state = "menu"
      }
  }

  EntityManager {
    id: entityManager
    // entities shall only be created in the gameScene
    //entityContainer: gameScene.entityContainer
  }

  state: "menu"

  states: [
    State {
      name: "menu"
      PropertyChanges {target: menuScene; opacity: 1}
      PropertyChanges {target: window; activeScene: menuScene}
      StateChangeScript {
        script: {
          //audioManager.play(audioManager.idSWOOSHING)
        }
      }
    },
    State {
      name: "shop"
      PropertyChanges {target: shopScene; opacity: 1}
      PropertyChanges {target: window; activeScene: shopScene}
      StateChangeScript {
        script: {
          //audioManager.play(audioManager.idSWOOSHING)
        }
      }
    },
    State {
      name: "game"
      PropertyChanges {target: gameScene; opacity: 1}
      PropertyChanges {target: window; activeScene: gameScene}
      StateChangeScript {
        script: {
          gameScene.enterScene()
          //audioManager.play(audioManager.idSWOOSHING)
        }
      }
    }
  ]
}

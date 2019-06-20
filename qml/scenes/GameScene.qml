import Felgo 3.0
import QtQuick 2.0
 import QtQuick.Controls.Styles 1.0

import "../game"
import "../common"
import "../entities"

SceneBase {

    id: scene
    signal menuPressed()
    signal shopPressed()
    signal useCoinsPressed()

    property bool levelStarted : false

    property int score: 0

    property bool isGameRunning: false

    property double gravityValue : 0.01

    property int player_initial_y: 20;

    property int size_of_char: 20



    //Access to local storage
    Storage {
      id: storage
    }

    PhysicsWorld {
       id: physicsWorld
       debugDrawVisible: false // physics debug overlay
       z: 1000 // on top of everything else
       gravity.y: gravityValue // 9.81 would be earth-like gravity

       updatesPerSecondForPhysics: 60

       velocityIterations: 5

       positionIterations: 5
     }


    MultiResolutionImage {
      id: bg
      source: "../../assets/img/bg.png"
    }


    Level {
        id: level
    }


    // Manage the 3 player independately on their platforms
    MouseArea {
        id: mouse
          anchors.fill: scene
          onPressed: {
            if(isGameRunning) {
              let chara

              //First platform
              if(mouse.y < 160 ) {
                  if (!level.two_plateform) return; // If platform is still locked
                  chara = entityManager.getEntityById("character_3")

              //Second platform
              }else if(mouse.y < 320 ) {
                  chara = entityManager.getEntityById("character_2")

              //Third platform
              }else if(mouse.y < 480) {
                  if (!level.three_plateform) return; // If platform is still locked
                  chara = entityManager.getEntityById("character_1")
              }

                chara.pushInDirection(Qt.point(mouse.x, mouse.y) )
            }
          }
      }



    EntityManager {
        id: entityManager
        entityContainer: scene
    }

    Timer {
         id: createObstacles // after the game initialization is complete we start the timer manually using the id
         interval: getInterval() // milliseconds
         repeat: true
         onTriggered: {
             if(isGameRunning) {
                score += 1
                level.createObstacle()
             }
         }
    }

    // how long wait before adding a new obstacle
    function getInterval() {
        let min_interval = 300
        let interval = 2000 - score * 50;

        interval = interval < min_interval ? min_interval : interval //Don't go above limit
        return interval
    }



    // overlay on game over
      GameOverScreen {
        z: 400
        id: gameOverStats

        onPlayPressed: {
            scene.state = "wait"
            ad_interstitial.showInterstitialIfLoaded()
            ad_interstitial.loadInterstitial()
        }

        onBackToMenuPressed: {
           console.log("on menu prssed")
           exitScene()
        }
      }

    // overlay on pause
      BreakScreen {
          z: 400
          id: breakScreen
          onPlayPressed: scene.state = "play"
          onBackToMenuPressed: {
              //scene.state = "gameOver"
              exitScene()
          }
      }



    // score
    Text {
       color: "white"
       id: score_displayer
       text: score
       anchors.right: parent.right
       anchors.bottom: parent.bottom
    }


    BreakButton {
        id: break_button

        real_width: 20
        real_height: 20

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.rightMargin: 10
        onClicked: { scene.state = "pause"; }
    }



    // get-ready screen
    WaitScreen {
      id: waitToPlay
      z: 100
      onClicked: {
        scene.state = "play"
      }
    }

    onBackButtonPressed: {
      if(scene.state == "gameOver") mainItem.state = "menu"
      scene.state = "gameOver"
    }

    function enterScene() {
      scene.state = "wait"
    }

    function exitScene() {
      menuPressed()
    }

    function initGame() {
      level.reset() //Clear all entities, even players
      setupPlayers()

      //Inform level of existing players
      level.setPlayers(entityManager.getEntityById("character_1"),
                       entityManager.getEntityById("character_2"),
                       entityManager.getEntityById("character_3"))

      //Hide players on locked platforms
      level.hideUnnecessaryPlayers()

      score = 0
      levelStarted = false
    }

    function startGame() {

      level.start()
      isGameRunning = true
      scene.state = "play"


      entityManager.getEntityById("character_1").start()
      entityManager.getEntityById("character_2").start()
      entityManager.getEntityById("character_3").start()

      if( levelStarted === false ) {
          entityManager.getEntityById("character_1").fall()
          entityManager.getEntityById("character_2").fall()
          entityManager.getEntityById("character_3").fall()
      }


      createObstacles.start()
      levelStarted  = true
    }

    function stopGame() {
      level.stop()
      entityManager.getEntityById("character_1").stop()
      entityManager.getEntityById("character_2").stop()
      entityManager.getEntityById("character_3").stop()
      isGameRunning = false

    }

    function gameOver() {
      stopGame()
      scene.state = "gameOver"
      level.gameOver()
      if(score > 0) {
        //TODO submit score and save it
          console.log("score : " + score)
      }
    }


    function  setupPlayers() {

        let entityProperties1 = {
            entityId: "character_1",
            resetX: scene.width/2 - size_of_char/2,
            resetY: (480/3) * 2 + player_initial_y, // On the top platform
        }

        let entityProperties2 = {
            entityId: "character_2",
            resetX: scene.width/2 - size_of_char/2,
            resetY: 480/3 + player_initial_y, // On the middle platform
        }

        let entityProperties3 = {
            entityId: "character_3",
            resetX: scene.width/2 - size_of_char/2,
            resetY: 0 + player_initial_y, // On the bottom platform
        }

        //Create 3 players
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Player.qml"), entityProperties1);
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Player.qml"), entityProperties2);
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Player.qml"), entityProperties3);
    }


      state: "wait"

      states: [
        State {
          name: "wait"
          PropertyChanges {target: waitToPlay; opacity : 1}
          PropertyChanges {target: physicsWorld; gravity: Qt.point(0,0)}

          StateChangeScript {
            script: {
              initGame()
            }
          }
        },
        State {
          name: "play"
          PropertyChanges {target: physicsWorld; gravity: Qt.point(0,gravityValue)}
          PropertyChanges {target: break_button; visible: true }
          StateChangeScript {
            script: {
              startGame()
            }
          }
        },
        State {
          name: "gameOver"
          PropertyChanges {target: gameOverStats; opacity: 1}
          PropertyChanges {target: physicsWorld; gravity: Qt.point(0,0)}
          StateChangeScript {
            script: {
              gameOver()
            }
          }
        },
      State {
        name: "pause"
        PropertyChanges {target: breakScreen; opacity: 1}
        PropertyChanges {target: physicsWorld; gravity: Qt.point(0,0)}
        StateChangeScript {
          script: {
            stopGame()
          }
        }
      }
    ]

      AdMobInterstitial {
        id: ad_interstitial
        adUnitId: "ca-app-pub-3940256099942544/1033173712" // interstitial test ad by AdMob
        testDeviceIds: [ "<your-test-device-id>" ]

        onInterstitialReceived: {
          //showInterstitialIfLoaded()
        }
        onPluginLoaded: {
          loadInterstitial()
        }
      }

}

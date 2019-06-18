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

    property int score: 0

    property bool isGameRunning: false

    property int gravityValue : 20

    property int player_initial_y: 20;

    property int size_of_char: 20




    PhysicsWorld {
       id: physicsWorld
       debugDrawVisible: true // physics debug overlay
       z: 1000 // on top of everything else
       gravity.y: gravityValue // 9.81 would be earth-like gravity

       updatesPerSecondForPhysics: 60

       velocityIterations: 5
       positionIterations: 5

       Rectangle {
           id: onBreak
           anchors.fill: scene
           color: "black"
           opacity: 0
           visible: opacity === 0 ? false : true
           enabled: false
       }

     }



    Level {
        id: level
    }


    Player {
        id: character_1
        resetX: scene.width/2 - size_of_char/2
        resetY: (480/3) * 2 + player_initial_y // On the top platform
    }

    Player {
        id: character_2
        resetX: scene.width/2 - size_of_char/2
        resetY: 480/3 + player_initial_y // On the middle platform
    }

    Player {
        id: character_3
        resetX: scene.width/2 - size_of_char/2
        resetY: 0 + player_initial_y // On the bottom platform
    }



    // Manage the 3 platform independately
    MouseArea {
        id: mouse
          anchors.fill: scene
          onPressed: {
            if(isGameRunning) {
              if(mouse.y < 160 && level.three_plateform) {
                  character_3.push()
              }else if(mouse.y < 320 ) {
                  character_2.push()
              }else if(mouse.y < 480 && level.two_plateform ) {
                  character_1.push()
              }
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
        let min_interval = 200
        let interval = 2000 - score * 50;

        interval = interval < min_interval ? min_interval : interval //Don't go above limit
        return interval
    }



    // overlay on game over
      GameOverScreen {
        id: gameOverStats

        onPlayPressed: {
            scene.state = "wait"
            console.log("play pressed")
        }
      }

    // overlay on pause
      BreakScreen {
          id: breakScreen
          onPlayPressed: state = "play"
          onBackToMenuPressed: {
              state = "gameOver"
              exitScene()
          }
      }



    // score / back to menu
    Text {
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
        onClicked: { scene.state = "pause"; console.log("pause game"); console.log(scene.state) }
    }



    // get-ready screen
    WaitScreen {
      id: waitToPlay
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
      level.reset()
      score = 0
    }

    function startGame() {
      level.start()
      isGameRunning = true
      scene.state = "play"
      physicsWorld.update() // Characters should fall

      createObstacles.start()
    }

    function stopGame() {
      level.stop()
      isGameRunning= false

    }

    function gameOver() {
      if(state === "gameOver") return; //Already game over !
      stopGame()
      scene.state = "gameOver"
      level.gameOver()
      if(score > 0) {
        //TODO submit score and save it
          console.log("score : " + score)
      }
    }

    function pauseGame() {

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
          PropertyChanges {target: physicsWorld; gravity: Qt.point(0,gravityValue*3)}
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
        PropertyChanges {target: onBreak; opacity: 0.8}
        StateChangeScript {
          script: {
            stopGame()
          }
        }
      }
    ]

}

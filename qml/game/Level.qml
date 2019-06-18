import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../common"


Item {

    property var obstacles: [] // Actually cows
    property int obstaclesCount : 0

    property int y_plateform_1 : 0 //(480/3)*2 //+ ground1.height
    property int y_plateform_2 : 480/3     + ground2.height
    property int y_plateform_3 : 0         + ground3.height

    property bool two_plateform: false
    property bool three_plateform: false


    BorderElement {
      x: scene.gameWindowAnchorItem.x
      y: scene.gameWindowAnchorItem.y-20
      width: scene.gameWindowAnchorItem.width
      height: 2
    }

    BorderElement {
      y: 0
      x: scene.gameWindowAnchorItem.x
      width: scene.gameWindowAnchorItem.width
      height: 2
  }



    Platform {
        id: character_1_stage
        anchors.top: parent.top;
        Ground {
          id: ground1
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom
          z:10
        }
        GroundCollision {
            id: coll_1
            anchors.fill: ground1
        }

        LockedElement {
            id: locked_plat_1
        }

    }




Platform {
    id: character_2_stage
    anchors.top: character_1_stage.bottom;
    Ground {
      id: ground2
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      z:10
    }

    GroundCollision {
        id: coll_2
        anchors.fill: ground2
    }
}



Platform {
    id: character_3_stage
    anchors.top: character_2_stage.bottom;
    Ground {
      id: ground3
      anchors.horizontalCenter: parent.horizontalCenter
      //y: scene.gameWindowAnchorItem.y+scene.gameWindowAnchorItem.height-height
      anchors.bottom: parent.bottom
      z:10
    }

    GroundCollision {
        id: coll_3
        anchors.fill: ground3
    }

    LockedElement {
        id: locked_plat_3
    }


}

  function reset() {
    entityManager.removeAllEntities()
    obstacles.length = 0;
  }

  function stop() {
      //character_1.fallDown(1000)
      for(var i = 0; i < obstacles.length; i++) {
          obstacles[i].stopMovement()
      }
  }

  function start() {
      for(var i = 0; i < obstacles.length; i++) {
          obstacles[i].startMovement()
      }
  }

  function gameOver() {
      console.log("lvel gmov")
      coll_1.enabled = false
      coll_1.sleeping = true
      coll_1.update()
      coll_1.active = false
  }

  function createObstacle() {

      //Unlock plateforms if necessary
      if(score >= 10) {two_plateform = true; locked_plat_1.visible = false}
      if(score >= 50) {three_plateform = true; locked_plat_3.visible = false }

      let entityProperties; let y;
      let random = Math.floor(Math.random() * 10) // between 0 and 9
      if( random < 7 ) { // 70% of chance to get a flying cow
          y = getObstacleHeight(false);
          entityProperties = {
              x: scene.width + 10,
              y: y,
              velocity: -100,
              id: "cow"+obstaclesCount,

              //Up and down movements
              min_y: y-10,
              max_y: y+10
          }
      }else {
          y = getObstacleHeight(true); // Ground only
          entityProperties = {
              x: scene.width + 10,
              y: y,
              velocity: -120,
              id: "cow"+obstaclesCount,

              //Cow shouldn't move up and down
              min_y: y,
              max_y: y
          }
      }

      let fromLeft = Math.floor(Math.random() * 2) // between 0 and 1 , 50% of chance to come from left

      if (fromLeft === 0) { // If cows should come from left instead of right by default
          entityProperties.x = -10
          entityProperties.velocity = - entityProperties.velocity // velocity must be inversed
      }





      entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Cow.qml"), entityProperties);
      obstacles.push(entityManager.getLastAddedEntity())
      obstaclesCount++
  }




  function getObstacleHeight(groundOnly) {

      //Heights of each plateform
      let heights = [y_plateform_2, y_plateform_1, y_plateform_3]

      /*for(var a = 0; a < heights.length; a++) {
           console.log(heights[a])
      }*/
      // By default only platform 2 is unlocked
      let max = 1 //Number of readable case in array, only first by default

      if(three_plateform) {
        max = 2
      }else if(two_plateform){
        max = 3
      }


      let random = Math.floor(Math.random() * (max - 1))

      random = 0
      let heightToReturn = heights[random]
      if(groundOnly) max = heightToReturn - 30; // on ground

      return heightToReturn
  }


}

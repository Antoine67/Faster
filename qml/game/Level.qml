import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../common"


Item {


    property int y_plateform_1
    property int y_plateform_2
    property int y_plateform_3
    property double heightPlatform
    property double spikeHeight : 31

    property int obstaclesCount: 0

    property bool two_plateform: false
    property bool three_plateform: false

    //Players
    property var p1
    property var p2
    property var p3



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

    BorderElement {
      y: scene.gameWindowAnchorItem.y
      x: 0
      width: 2
      height: scene.gameWindowAnchorItem.height
    }

    BorderElement {
      y: scene.gameWindowAnchorItem.y
      x: scene.gameWindowAnchorItem.width
      width: 2
      height: scene.gameWindowAnchorItem.height
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
            displayText: "Too easy ? Ugh.."
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
      anchors.bottom: parent.bottom
      z:10
    }

    GroundCollision {
        id: coll_3
        anchors.fill: ground3
    }

    LockedElement {
        id: locked_plat_3
        displayText: ""
    }


}

  function reset() {
    //entityManager.removeAllEntities()
    entityManager.removeEntitiesByFilter(["spike","player"])
    two_plateform = false
    three_plateform = false
    try {
        heightPlatform = character_1_stage.height- ground1.height
        y_plateform_1 = 0 + character_1_stage.height- ground1.height - 20
        y_plateform_2 = 480/3   + character_2_stage.height - ground2.height - 20
        y_plateform_3 = (480/3)*2 + character_3_stage.height- ground3.height - 20
    }catch (e) {console.log(e)}

   locked_plat_1.visible = true
   locked_plat_3.visible = true
  }

  function stop() {
      let obstacles = entityManager.getEntityArrayByType("spike")
      for(var i = 0; i < obstacles.length; i++) {
          if(obstacles[i] !== null ) obstacles[i].stopMovement()
      }
  }

  function start() {
      let obstacles = entityManager.getEntityArrayByType("spike")
      for(var i = 0; i < obstacles.length; i++) {
          if(obstacles[i] !== null ) obstacles[i].startMovement()
      }
  }

  function gameOver() {
      console.log("level game over")

  }

  function createObstacle() {

      //Unlock plateforms if necessary
      if(score >= 10) {
          two_plateform = true
          locked_plat_1.visible = false
          showPlayer(p3)
      }
      if(score >= 20) {
          three_plateform = true
          locked_plat_3.visible = false
          showPlayer(p1)
      }

      let entityProperties; let y;
      let random = Math.floor(Math.random() * 10) // between 0 and 9

      if( random < 3 ) { // 30% of chance to get a flying spike
          y = getObstacleHeight(false);
          entityProperties = {
              x: scene.width + 10,
              y: y,
              velocity: -50,
              id: "spike"+obstaclesCount,
              shouldReversePicture: true,

              //Up and down movements
              min_y: y-10,
              max_y: y+10
          }
      }else {
          y = getObstacleHeight(true); // Ground only
          entityProperties = {
              x: scene.width + 10,
              y: y,
              velocity: -60,
              id: "spike"+obstaclesCount,
              shouldReversePicture: true,

              //Spikes mustn't move up and down
              min_y: y,
              max_y: y
          }
      }

      let fromLeft = Math.floor(Math.random() * 2) // between 0 and 1 , 50% of chance to come from left

      if (fromLeft === 0) { // If spike should come from left instead of right by default
          entityProperties.x = -10
          entityProperties.velocity = - entityProperties.velocity // velocity must be inversed
          entityProperties.shouldReversePicture = false
      }

      entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Spike.qml"), entityProperties);
      obstaclesCount++
  }




  function getObstacleHeight(groundOnly) {

      //Heights of each plateform
      let heights = [{min: y_plateform_2, max: y_plateform_2 - heightPlatform + spikeHeight},
                     {min: y_plateform_1, max: y_plateform_1 - heightPlatform + spikeHeight},
                     {min: y_plateform_3, max: y_plateform_3 - heightPlatform + spikeHeight}]

      // By default only platform 2 is unlocked
      let max = 1 //Number of readable case in array, only first by default

      if(three_plateform) {
        max = 3
      }else if(two_plateform){
        max = 2
      }


      let random = Math.floor(Math.random() * (max))

      let heightToReturn = heights[random]
      if(!groundOnly) heightToReturn = heightToReturn - 40; // flying

      return Math.floor(Math.random()*(heightToReturn.max - heightToReturn.min +1)+heightToReturn.min);
      //return
  }

  function setPlayers(player1, player2, player3) {
    p1 = player1
    p2 = player2
    p3 = player3

  }

  function hideUnnecessaryPlayers() {
      p1.visible = false
      p3.visible = false
  }

  function showPlayer(player) { player.visible = true}


}

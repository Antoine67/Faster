import QtQuick 2.0
import Felgo 3.0

EntityBase {

  property var id
  entityType: "box"
  entityId: id

  property int velocity: velocity
  property int max_y
  property int min_y

  height: cow_img.height
  width: cow_img.width

  MultiResolutionImage {
    id: cow_img
    source: "../../assets/img/bird_0.png"
    anchors.horizontalCenter: parent.horizontalCenter
  }

  BoxCollider {
     id: collider
     anchors.fill: cow_img
     bodyType: Body.Kinematic
     collisionTestingOnlyMode: true
     fixture.onBeginContact: {
           scene.gameOver()
     }
  }

  MovementAnimation {
    id: movement
    target: parent
    property: "x"
    minPropertyValue: -300
    maxPropertyValue: 1000
    acceleration: 10
    velocity: parent.velocity
    running: true
    onLimitReached: {

        removeEntity() // do not stack invisible entity outside the screen range
    }
  }

  MovementAnimation {
    id: movement_y
    target: parent
    property: "y"
    minPropertyValue: min_y
    maxPropertyValue: max_y
    velocity: - parent.velocity/10
    running: true
    onLimitReached: {
        velocity = -velocity
    }
  }


  function stopMovement() {
      movement.stop()
  }

  function startMovement() {
      movement.start()
  }




}

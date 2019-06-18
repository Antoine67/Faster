import QtQuick 2.0
import Felgo 3.0

EntityBase {

  property var id
  entityType: "spike"
  entityId: id

  property int velocity: velocity
  property int max_y
  property int min_y
  property bool shouldReversePicture

  height: spike_img.height
  width: spike_img.width

  /*MultiResolutionImage {
    id: spike_img
    source: "../../assets/img/bird.png"
    anchors.horizontalCenter: parent.horizontalCenter

  }*/

  SpriteSequence {
     id: spriteSequence
     mirrorX: shouldReversePicture

     anchors.centerIn: parent

     Sprite {
       name: "spike_img"
       id: spike_img
       frameCount: 3
       frameRate: 10

       frameWidth: 32
       frameHeight: 31
       source: "../../assets/img/bird.png"
     }
     //rotation: collider.linearVelocity.y/10
   }

  BoxCollider {
     id: collider
     anchors.fill: spriteSequence
     bodyType: Body.Kinematic
     collisionTestingOnlyMode: true
     fixture.onBeginContact: {
           scene.gameOver()
     }
  }

  MovementAnimation {
    id: movement_x
    target: parent
    property: "x"
    minPropertyValue: -100
    maxPropertyValue: 1000
    acceleration: 0
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
      movement_x.stop()
      movement_y.stop()
      spriteSequence.running = false
  }

  function startMovement() {
      movement_x.start()
      movement_y.start()
      spriteSequence.running = true
  }





}

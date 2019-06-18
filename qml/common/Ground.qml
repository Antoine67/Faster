import Felgo 3.0
import QtQuick 2.0

EntityBase {
  property int entityId;

  entityType: "box"

  width: parent.width
  height: spriteSequence.height

  /*SpriteSequence {
    id: spriteSequence

    Sprite {
      frameCount: 2
      frameRate: 4
      frameWidth: 368
      frameHeight: 90
      source: "../../assets/img/land.png"
    }
  }
  */


  MultiResolutionImage {
    id: spriteSequence
    source: "../../assets/img/landSprite.png"
    anchors.fill: parent
  }




  function reset() {
    spriteSequence.running = true
  }

  function stop() {
    spriteSequence.running = false
  }
}

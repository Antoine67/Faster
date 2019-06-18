import QtQuick 2.0
import Felgo 3.0


EntityBase {
  id: player
  entityType: "player"

  property real upwardforce: -50
  property real sideforce: 30
  property int resetX: 0
  property int resetY: 0

  width: collider.radius * 2
  height: collider.radius * 2

  signal gameOver()

  Component.onCompleted: reset()

  onGameOver: {
    spriteSequence.running = false
  }

 /*SpriteSequence {
    id: spriteSequence

    anchors.centerIn: parent

    Sprite {
      name: "idle"
      frameCount: 3
      frameRate: 10

      frameWidth: 34
      frameHeight: 24
      source: "../../assets/img/birdSprite.png"
    }
    rotation: collider.linearVelocity.y/10
  }*/

  MultiResolutionImage {
      id: spriteSequence

      anchors.centerIn: parent
      source: "../../assets/img/ballon.png"

      rotation: collider.linearVelocity.y/10

  }

  CircleCollider {
    id: collider

    radius: spriteSequence.height/2
    bodyType: Body.Dynamic
  }

  function reset() {
    player.x = resetX
    player.y = resetY
    collider.body.linearVelocity = Qt.point(0,0)
  }

  function push() {
    //audioManager.play(audioManager.idWING)
    collider.body.linearVelocity = Qt.point(0,0)
    var localForwardVector = collider.body.toWorldVector(Qt.point(0, upwardforce));
    collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
  }

  function pushLeft(goUp) {
      //audioManager.play(audioManager.idWING)
      let forceUp = 0
      if(goUp) forceUp = upwardforce

      collider.body.linearVelocity = Qt.point(0,0)
      var localForwardVector = collider.body.toWorldVector(Qt.point(-sideforce, forceUp));
      collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
  }

  function pushRight(goUp) {
      let forceUp = 0
      if(goUp) forceUp = upwardforce

      collider.body.linearVelocity = Qt.point(0,0)
      var localForwardVector = collider.body.toWorldVector(Qt.point(sideforce, forceUp));
      collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
  }

  function stop() {

  }

}

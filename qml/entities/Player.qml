import QtQuick 2.0
import Felgo 3.0


EntityBase {
  id: player
  entityType: "player"

  property real upwardforce: -50
  property real sideforce: 50
  property int resetX: 0
  property int resetY: 0

  property string balloonName : storage.getValue("playerSkin")

  property point velocityBeforePause : Qt.point(0,-1)

  width: collider.radius * 2
  height: collider.radius * 2

  signal gameOver()

  Component.onCompleted: reset()

  onGameOver: {
    spriteSequence.running = false
  }

  //Access to local storage
  Storage {
    id: storage
  }


  MultiResolutionImage {
      id: spriteSequence

      anchors.centerIn: parent
      source: "../../assets/img/"+balloonName

      rotation: collider.linearVelocity.y/10

  }

  CircleCollider {
    id: collider

    property point target //:  Qt.point(-200, -200)

    friction: 2

    radius: spriteSequence.height/2
    bodyType: Body.Dynamic

    function slowPlayer() {
        if(!target ) return;

        if( Math.abs(getRealX() - target.x) < 5 && Math.abs(getRealY() - target.y) < 5 )
        body.linearVelocity = getVelocity(target, Qt.point(getRealX(), getRealY())); return;
    }
  }


  function getVelocity (target, player) {
      let minVelocity = 0
      let maxVelocity = 100

      let vector = Qt.point(target.x - player.x,
                            target.y - player.y)

      vector.x = limitVelocity(vector.x, minVelocity, maxVelocity)
      vector.y = limitVelocity(vector.y, minVelocity, maxVelocity)

      return vector

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


  function pushInDirection(dir) {
      let vector = Qt.point(dir.x - getRealX(),
                            dir.y - getRealY())


      collider.body.linearVelocity = Qt.point(0,0)
      var localForwardVector = collider.body.toWorldVector(vector);
      collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());

      collider.target.x = dir.x
      collider.target.y = dir.y

      //audioManager.play(audioManager.idWING)
  }



  Timer {
       id: timerSlow // after the game initialization is complete we start the timer manually using the id
       interval: 50
       repeat: true
       onTriggered: {
        collider.slowPlayer()
       }
  }


  function limitVelocity(el, min, max) {

     // Negative velocity
    if (el < 0) {
        if(el + min > 0) { el = -min } // Not fast enough
        else if(el + max < 0)  { el = -max } // Too fast

    // Same for positive velocity
    }else {
        if(el - min < 0) { el = min }
        else if(el - max > 0)  { el = max }
    }
    return el
  }

  function stop() {

    velocityBeforePause = Qt.point(collider.body.linearVelocity.x, collider.body.linearVelocity.y)

    collider.body.linearVelocity = Qt.point(0,0)

    timerSlow.stop()
  }

  function start() {
      if (velocityBeforePause) collider.body.linearVelocity = velocityBeforePause
      timerSlow.start()
  }

  function getRealX() {
    return x + player.width/2
  }

  function getRealY() {
    return y + player.height/2
  }

  function fall() {
       collider.body.applyLinearImpulse(Qt.point(0, 10), collider.body.getWorldCenter());
  }

}

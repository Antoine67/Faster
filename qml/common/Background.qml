import Felgo 3.0
import QtQuick 2.0

import "../entities"

Item {
  width: bg.width
  height: bg.height
  MultiResolutionImage {
    id: bg
    source: "../../assets/img/bg.png"


  }

  Player {
    id: balloon
    x: 50
    y: 350
    resetX: 50
    resetY:  350
    balloonName: "balloon"
  }

  Player {
    id: balloon2
    x: 100
    y: 400
    resetX: 130
    resetY: 320
    balloonName: "balloon2"
  }

  Player {
    id: balloon3
    x: 150
    y: 370
    resetX: 150
    resetY: 370
    balloonName: "balloon3"
  }

  Player {
    id: balloon4
    x: 200
    y: 355
    resetX: 170
    resetY: 355
    balloonName: "balloon4"
  }

  Player {
    id: balloon5
    x: 250
    y: 355
    resetX: 170
    resetY: 320
    balloonName: "balloon5"
  }




  function start() {
      balloon.activateWabbling()
      balloon2.activateWabbling()
      balloon3.activateWabbling()
      balloon4.activateWabbling()
      balloon5.activateWabbling()
  }


}

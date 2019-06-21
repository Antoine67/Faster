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
    balloonName: "ballon"
  }

  Player {
    id: balloon2
    x: 130
    y: 320
    resetX: 130
    resetY: 320
    balloonName: "ballon2"
  }

  Player {
    id: balloon3
    x: 150
    y: 370
    resetX: 150
    resetY: 370
    balloonName: "ballon3"
  }

  Player {
    id: balloon4
    x: 190
    y: 355
    resetX: 170
    resetY: 355
    balloonName: "ballon4"
  }




  function start() {
      balloon.activateWabbling()
      balloon2.activateWabbling()
      balloon3.activateWabbling()
      balloon4.activateWabbling()
  }


}

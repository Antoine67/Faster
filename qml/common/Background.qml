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
    id: balloon4
    x: scene.gameWindowAnchorItem.width/2 - balloon4.width/2
    y: scene.gameWindowAnchorItem.height*0.8
    resetX: scene.gameWindowAnchorItem.width/2 - balloon4.width/2
    resetY: scene.gameWindowAnchorItem.height*0.8
    balloonName: "ballon4"
  }
/*
  MovementAnimation {
    target: balloon4
    property: "x"
    velocity: 10
    running: true
    minPropertyValue: -100
    maxPropertyValue: 100
    acceleration: 0
  }

  MovementAnimation {
    target: balloon4
    property: "y"
    velocity: 10
    running: true
    minPropertyValue: -100
    maxPropertyValue: 100
    acceleration: 0
  }*/


}

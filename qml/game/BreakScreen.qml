import Felgo 3.0
import QtQuick 2.0
import "../scenes"
import "../common"

Item {
  width: parent.width
  height: parent.height
  anchors.top: parent.top
  //y: -30
  opacity: 0
  visible: opacity === 0 ? false : true
  enabled: visible

  signal playPressed()
  signal exitPressed()
  signal backToMenuPressed()

  Rectangle {
      id: onBreak
      anchors.fill: parent
      color: "black"
      opacity: 0.5
  }


  Text {
      id: name
      text: qsTr("Pause")
      anchors.top : parent.top

  }

/*
  MultiResolutionImage {
    source: "../../assets/img/gameOver.png"
    anchors.bottom: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
  }

  MultiResolutionImage {
    id: scoreBoard
    anchors.centerIn: parent
    source: "../../assets/img/scoreBoard.png"
  }*/


  MenuBreak {
    anchors.centerIn: parent
    onPlayPressed: parent.playPressed()
    onBackToMenuPressed: parent.backToMenuPressed()
  }



}

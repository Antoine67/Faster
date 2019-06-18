import Felgo 3.0
import QtQuick 2.0
import "../scenes"
import "../common"

Item {
  width: parent.width
  height: parent.height
  y: -30
  opacity: 0
  visible: opacity === 0 ? false : true
  enabled: visible

  signal playPressed()

  MultiResolutionImage {
    source: "../../assets/img/gameOver.png"
    anchors.bottom: scoreBoard.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
  }

  MultiResolutionImage {
    id: scoreBoard
    anchors.centerIn: parent
    source: "../../assets/img/scoreBoard.png"
  }


  Menu {
    anchors.top: scoreBoard.bottom
    anchors.topMargin: 15
    onPlayPressed: parent.playPressed()
  }

}

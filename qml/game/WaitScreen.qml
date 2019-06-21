import Felgo 3.0
import QtQuick 2.0

Item {
  width: parent.width
  height: parent.height
  y: -30
  opacity: 0
  visible: opacity === 0 ? false : true
  enabled: visible

  signal clicked()

  /*MultiResolutionImage {
    source: "../../assets/img/getReady.png"
    anchors.bottom: tutorial.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
  }*/


  Text {
    //source: "../../assets/img/gameOver.png"
    anchors.bottom: tutorial.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
    font.family: customFont.name
    font.pixelSize: 40
    font.bold: true
    color: "#2bff4b"
    text: "Ready ?"


  }

  MultiResolutionImage {
    id: tutorial
    anchors.centerIn: parent
    source: "../../assets/img/tutorial.png"
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      parent.clicked()
    }
  }
}

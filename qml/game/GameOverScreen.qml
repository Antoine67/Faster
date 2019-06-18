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
  signal backToMenuPressed()

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

  MouseArea {
      anchors.fill: scoreBoard
      onPressed: { /*parent.backToMenuPressed();*/ console.log("clicked")  }
  }


  Menu {
    id: menuGameOver
    anchors.top: scoreBoard.bottom
    anchors.topMargin: 15
    onPlayPressed: parent.playPressed()
  }

  AdMobBanner {
           id: adBanner
           adUnitId: Constants.admobBannerAdUnitId
           banner: AdMobBanner.Smart

           anchors.horizontalCenter: parent.horizontalCenter
           //anchors.bottom: parent.bottom
            anchors.centerIn: parent
           testDeviceIds: Constants.admobTestDeviceIds
           height: 50
           z: 10000
           visible: true
           opacity: 1

           Rectangle {
               anchors.fill: adBanner
               color: "red"
           }
  }


}

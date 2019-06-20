import Felgo 3.0
import QtQuick 2.0
import "../scenes"
import "../common"
import "../helper"

Item {
  width: parent.width
  height: parent.height
  y: -30
  opacity: 0
  visible: opacity === 0 ? false : true
  enabled: visible

  signal playPressed()
  signal backToMenuPressed()

  Rectangle {
      id: onBreak
      anchors.fill: parent
      color: "black"
      opacity: 0.5
  }

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


  MenuGameOver {
    id: menuGameOver
    anchors.top: scoreBoard.bottom
    anchors.topMargin: 15
    onPlayPressed: parent.playPressed()
    onBackToMenuPressed: parent.backToMenuPressed()
  }

  AdMobBanner {
           id: adBanner
           adUnitId: Constants.admobBannerAdUnitId
           banner: AdMobBanner.Smart

           anchors.horizontalCenter: parent.horizontalCenter
           //anchors.bottom: parent.bottom
           //anchors.centerIn: parent
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

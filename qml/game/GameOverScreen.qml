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

  Text {
    id: gameOverLabel
    //source: "../../assets/img/gameOver.png"
    anchors.bottom: scoreBoard.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
    font.family: customFont.name
    font.pixelSize: 40
    font.bold: true
    color: "red"
    text: "Game Over"


  }

  Item {

      id: newRecordDisplayer
      visible: false
      anchors.topMargin: 10
      anchors.rightMargin: 10
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter


      Text {
          id: newRecordLabel
          text: qsTr("New best score!")
          anchors.horizontalCenter: parent.horizontalCenter
          font.pixelSize: 30
          font.family: customFont.name
          color: "yellow"
      }

      MultiResolutionImage {
        id: star
        anchors.top: newRecordLabel.bottom
        anchors.horizontalCenter: parent.horizontalCenter


        source: "../../assets/img/star.png"

      }
  }


 /* MultiResolutionImage {
    id: scoreBoard
    anchors.centerIn: parent
    source: "../../assets/img/scoreBoard.png"

  }*/

  Item {
      id: scoreBoard
      anchors.centerIn: parent
      Text {
          anchors.centerIn: parent
          id: yourScore
          text: qsTr("Your score : ")
          font.pixelSize: 20
          font.family: customFont.name
          color: "white"
      }

      Text {
          id: scoreDisplayer
          text: qsTr(" ")
          anchors.left: yourScore.right
          anchors.verticalCenter: yourScore.verticalCenter
          font.pixelSize: 20
          font.family: customFont.name
          color: "white"
      }
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
           banner: AdMobBanner.Standard

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
               z:80
           }

  }

  function updateStats(score, bestScore) {
      newRecordDisplayer.visible = score > bestScore
      scoreDisplayer.text = score

      if(score > bestScore) {
        scoreDisplayer.color = "yellow"
      }else {
        scoreDisplayer.color = "white"
      }


  }


}

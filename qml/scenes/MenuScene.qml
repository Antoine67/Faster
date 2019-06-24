import QtQuick 2.0
import Felgo 3.0
import "../entities"
import "../common"

SceneBase {
  id: scene

  signal gamePressed()
  signal shopPressed()


  Storage {
      id: storage
  }

  Background {
    id: bg
  }

  Text {
      id: score
      text: "Best score : "+storage.getValue("bestScore")
      font.pixelSize: 30
      font.family: customFont.name
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
  }


  MultiResolutionImage {
    anchors.top: parent.top
    anchors.topMargin: 60
    //anchors.horizontalCenter: parent
    source: "../../assets/img/logo.png"

    width: parent.width
    height: width * 0.38146551724 //proportion
  }


  Menu {
    anchors.centerIn: parent
    onShopPressed: parent.shopPressed()
    onPlayPressed: gamePressed()
  }

  onEnterPressed: {
    gamePressed()
  }

  function updateScore() {
      score.text =  "Best score : "+storage.getValue("bestScore")
      bg.start()
      audioManager.play(audioManager.idMAIN_MUSIC)
  }


}

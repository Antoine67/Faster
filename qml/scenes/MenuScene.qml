import QtQuick 2.0
import Felgo 3.0
import "../entities"
import "../common"

SceneBase {
  id: scene

  signal gamePressed()
  signal shopPressed()

  Player {
    x: scene.gameWindowAnchorItem.width/2
    y: scene.gameWindowAnchorItem.height/2
    resetX: scene.gameWindowAnchorItem.width/2;
    resetY: scene.gameWindowAnchorItem.height/2
  }

  MultiResolutionImage {
    anchors.top: parent.top
    anchors.topMargin: 60
    anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
    source: "../../assets/img/logo.png"
  }


  Menu {
    onShopPressed: parent.shopPressed()
    onPlayPressed: gamePressed()
  }

  onEnterPressed: {
    gamePressed()
  }
}

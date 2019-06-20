import QtQuick 2.0
import Felgo 3.0
import "../entities"
import "../common"

SceneBase {
  id: scene

  signal gamePressed()
  signal shopPressed()


  Background {

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


}

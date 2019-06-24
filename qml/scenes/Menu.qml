import Felgo 3.0
import QtQuick 2.0

Row {
  signal playPressed()
  signal shopPressed()

  spacing: 18
  anchors.horizontalCenter: parent.horizontalCenter
  height: menuItem.height

  //Launch game
  ImageButton {
    id: menuItem
    onClicked: {
      playPressed()
    }
    source: "../../assets/img/playAgain.png"
  }

  //Shop
  ImageButton {
    onClicked: {
      shopPressed()
    }
    source: "../../assets/img/shopButton.png"
  }
}

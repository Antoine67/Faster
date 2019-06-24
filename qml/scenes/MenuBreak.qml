import Felgo 3.0
import QtQuick 2.0

Row {
  signal playPressed()
  signal backToMenuPressed()

  spacing: 18
  anchors.horizontalCenter: parent.horizontalCenter

  height: menuItem.height

  //Launch game
  ImageButton {
    id: menuItem
    onClicked: {
      parent.playPressed()
    }
    source: "../../assets/img/playAgain.png"
  }

  //Shop
  ImageButton {
    onClicked: {
      parent.backToMenuPressed()
    }
    source: "../../assets/img/backToMenu.png"
  }
}

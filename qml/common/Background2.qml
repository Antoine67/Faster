import Felgo 3.0
import QtQuick 2.0

// EMPTY SCENE

Item {

    anchors.fill: parent
    width: bg.width
    height: bg.height
    MultiResolutionImage {
      id: bg
      source: "../../assets/img/bg.png"


    }

}

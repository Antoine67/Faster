import Felgo 3.0
import QtQuick 2.0

Item {


    width: 320
    height: 480/3

    MultiResolutionImage {
      id: bg
      source: "../../assets/img/bg.png"
    }

    Ground {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom

      z:10
    }


}

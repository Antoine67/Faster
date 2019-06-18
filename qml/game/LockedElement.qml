import Felgo 3.0
import QtQuick 2.0

Item {
    z: 100 // Above game
    id: lockedElement
    anchors.fill: parent

    Rectangle {
        opacity: 0.9
        color : "black"
        anchors.fill: parent
    }

    MultiResolutionImage {
        source: "../../assets/img/bird_0.png"
        anchors.centerIn: parent

    }

}

import Felgo 3.0
import QtQuick 2.0

Item {

    signal clicked()

    property int real_width
    property int real_height
    property string real_color: "white"

    z: 10000

    visible: false

    width: real_width
    height: real_height

    Row {
        anchors.centerIn: parent
        // space between each item in the row
        spacing: dp(real_width/5)

        Rectangle {
            color: real_color
            width: real_width/3
            height: real_height
        }

        Rectangle {
            color: real_color
            width: real_width/3
            height: real_height
        }
    }



    MouseArea {
      anchors.fill: parent
      onClicked: parent.clicked()
    }

}

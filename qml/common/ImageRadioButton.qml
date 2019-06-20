import Felgo 3.0
import QtQuick 2.5
import QtQuick.Controls 2.0 as Quick2

Quick2.RadioButton {
  id: radioButton
  implicitWidth: leftPadding + indicator.implicitWidth + spacing + contentItem.implicitWidth + rightPadding
  implicitHeight: topPadding + indicator.implicitHeight + bottomPadding
  topPadding: 0
  bottomPadding: 0
  leftPadding: 0
  rightPadding: 0

  //pressed: onUserClick()
  onCheckedChanged: {
    if (checked) {
        onUserClick()
    }
  }



  property string img : "undefined"
  property string sprite : "undefined"

  property var onUserClick : function() { console.log("not defined yet")}

  // overwrite style for density-independent sizes
  contentItem: AppText {
    text: parent.text
    font.pixelSize: sp(12)
    anchors.left: parent.left
    anchors.leftMargin: parent.indicator.width + parent.indicator.x + parent.spacing
  }





  indicator: Item {
    implicitWidth: dp(36)
    implicitHeight: implicitWidth
    x: parent.leftPadding
    y: parent.height / 2 - height / 2
    Rectangle {

      anchors.centerIn: parent
      implicitWidth: parent.width
      implicitHeight: parent.height
      radius: 0
      border.color: radioButton.checked ? Theme.tintColor : Theme.secondaryTextColor
      border.width: 1
      color: "transparent"
      visible: radioButton.checked
      z: 5
    }

    MultiResolutionImage {

        visible: img !== "undefined"

        source: img !== "undefined" ? "../../assets/img/" + img + ".png" : "../../assets/img/ballon.png"
        width: 30
        height: 31
        anchors.centerIn: parent
        z: 10
    }

    SpriteSequence {
        z: 10
       id: spriteSequence

       visible: sprite !== "undefined"
       running: sprite !== "undefined"

       width: 30
       height: 31

       anchors.centerIn: parent

       Sprite {
         name: "spike_img"
         id: spike_img
         frameCount: 6
         frameRate: 10

         frameWidth: 32
         frameHeight: 31
         source: sprite !== "undefined" ? "../../assets/img/"+ sprite +".png" : "../../assets/img/bird.png"

       }
     }

  }



}

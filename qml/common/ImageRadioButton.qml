import Felgo 3.0
import QtQuick 2.5
import QtQuick.Controls 2.0 as Quick2

Quick2.RadioButton {
  id: radioButton
  implicitWidth: leftPadding + indicator.implicitWidth + spacing + contentItem.implicitWidth + rightPadding
  implicitHeight: topPadding + indicator.implicitHeight + bottomPadding
  topPadding: 10
  bottomPadding: 10
  leftPadding: 10
  rightPadding: 5

  onCheckedChanged: {
    if (checked) { onUserClick() } //onUserClick setup in ShopScene
  }


  property string img : "undefined"
  property string sprite : "undefined"

  property var onUserClick : function() { /* Default empty */}

  // overwrite style for density-independent sizes
  contentItem: AppText {
    text: parent.text
    font.pixelSize: sp(12)
    anchors.left: parent.left
    anchors.leftMargin: parent.indicator.width + parent.indicator.x + parent.spacing
  }

  //Border around image on check
  Rectangle {
    anchors.centerIn: parent
    implicitWidth: parent.width
    implicitHeight: parent.height
    radius: 100

    color: visible ? "white" : "transparent"
    visible: radioButton.checked
    opacity: 0.6
    z: 5
  }


  indicator: Item {
    implicitWidth: dp(36)
    implicitHeight: implicitWidth
    x: parent.leftPadding
    y: parent.height / 2 - height / 2
    z: 10

    //Display image or sprite over the radio button
    MultiResolutionImage {

        visible: img !== "undefined"
        source: img !== "undefined" ? "../../assets/img/" + img + ".png" : "../../assets/img/ballon.png"

        width: 30
        height: 31
        anchors.centerIn: parent

    }

    SpriteSequence {

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

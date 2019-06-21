import Felgo 3.0
import QtQuick 2.0

import "../common"

SceneBase {

    id: shopScene

    Component.onCompleted: {
        let balloons = ["ballon","ballon2","ballon3","ballon4"]
        let spikes = ["bird", "bird", "bird"]

        loadData(balloons, contentColumn, "Pick up a cool balloon", false )
        loadData(spikes, contentColumn, "Tired of birds ?", true )

    }

    property int numberOfItemPerRow : 3

    //Access to local storage
    Storage {
      id: storage
    }

    Background2 {
      id: bg
      z: 1
    }

    NavigationStack {
        z: 2
        initialPage: skinPage
        anchors.fill: parent



        Page {
            id: skinPage
            title: "Changing room"
            backgroundColor: "transparent"


            leftBarItem: NavigationBarItem {
                AppButton {
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height*0.8
                    horizontalPadding: 0
                    text: "⮜"
                    onClicked: {
                        mainItem.state = "menu"
                    }

                    z: 3
                }
            }

            AppFlickable {
                id: contentDispl
                anchors.fill: parent
                contentWidth: contentColumn.width
                contentHeight: contentColumn.height

                // The height of the column is set automatically depending on the child items
                Column {
                  id: contentColumn
                  width: skinPage.width
                }
            }
        }
    }

    function loadData(data, targetRow, title, isSpike) {

        Qt.createQmlObject('import QtQuick 2.0; Text {  font.pixelSize: 20; color: "#3281ff"; anchors.horizontalCenter: parent.horizontalCenter; anchors.topMargin: 10; anchors.bottomMargin: 3; text: "'+ title + '"}', targetRow)

        let row = Qt.createQmlObject('import QtQuick 2.0; Grid { z: 2 ;anchors.horizontalCenter: parent.horizontalCenter; columns: '+numberOfItemPerRow+'; spacing: 2}', targetRow)

        for(var nbRows = 0; nbRows < data.length; nbRows+=numberOfItemPerRow) { // A row contains 'numberOfItemPerRow' items

            for(var item = nbRows; item< nbRows+numberOfItemPerRow; item++) { // Display each item

                //Create custom radio button with skin of current data
                if( data[item] ) { //If not a multiple of 'numberOfItemPerRow'
                    let comp = Qt.createComponent("../common/ImageRadioButton.qml")
                    let checkBox;
                    if( !isSpike ) {
                        checkBox = comp.createObject(row, {img : data[item] });
                    }else {
                        checkBox = comp.createObject(row, {sprite : data[item] });
                    }

                    if (checkBox === null) { console.log("Error creating object"); return;}
                    checkBox = checkAndAddFunction (checkBox, data[item], isSpike)

                }
            }
        }
    }

    function checkAndAddFunction(checkBox, valueStr, isSpike) {
         if (!isSpike && valueStr === storage.getValue("playerSkin")) checkBox.checked = true
         if (isSpike && valueStr === storage.getValue("enemySkin")) checkBox.checked = true

         if(!isSpike) {
             checkBox.onUserClick = function () {
             storage.setValue("playerSkin", valueStr)
             //audioManager.play(audioManager.idSELECTION_CHANGED)
             //console.log("playerSkin updated to "+valueStr)
             }
         }else {
             checkBox.onUserClick = function () {
             storage.setValue("enemySkin", valueStr)
             //audioManager.play(audioManager.idSELECTION_CHANGED)
             //console.log("enemySkin updated to "+valueStr)
             }
         }

         return checkBox

    }

}

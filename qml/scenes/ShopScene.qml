import Felgo 3.0
import QtQuick 2.0

import "../common"

SceneBase {

    id: shopScene

    Component.onCompleted: {
        let balloons = ["ballon","ballon2","ballon3","ballon4"]
        let spikes = ["bird", "bird", "bird"]

        loadData(balloons, contentColumn, "Change your skin", false )

        loadData(spikes, contentColumn, "Change the enemy skin", true )




    }

    property int numberOfItemPerRow : 3

    //Access to local storage
    Storage {
      id: storage
    }





    NavigationStack {

        initialPage: skinPage

        Page {
            id: skinPage
            title: "Shop (not really all is free)"

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

        Qt.createQmlObject('import QtQuick 2.0; Text { anchors.horizontalCenter: parent.horizontalCenter; text: "'+ title + '"}', targetRow)

        let row = Qt.createQmlObject('import QtQuick 2.0; Grid { anchors.horizontalCenter: parent.horizontalCenter; columns: 3; spacing: 2}', targetRow)

        for(var nbRows = 0; nbRows < data.length; nbRows+=numberOfItemPerRow) { // A row contains 'numberOfItemPerRow' items

            //let row = Qt.createQmlObject('import QtQuick 2.0; Row {}',contentColumn)

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
                 console.log("playerSkin updated to "+valueStr)
             }
         }else {
             checkBox.onUserClick = function () {
                storage.setValue("enemySkin", valueStr)
                 console.log("enemySkin updated to "+valueStr)
             }
         }

         return checkBox

    }

}

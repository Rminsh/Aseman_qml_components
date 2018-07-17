import QtQuick 2.9
import QtQuick.Window 2.2
import AsemanTools 1.1
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    ListModel {
        id:items
        function refresh() {
            clear()
            append( {"name": qsTr("Snackbar"),     "icon": "\uf6fa"} )
            append( {"name": qsTr("Text Fields"),  "icon": "\uf60e"} )
        }
        Component.onCompleted: refresh()
    }

    AsemanGridView {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10
        cellWidth: parent.width / 2 - (10*Devices.density)
        model: items
        delegate: Pane {
            id:menuItem
            height: 100 * Devices.density - (10*Devices.density)
            width: parent.width/2 - (10*Devices.density)
            Material.elevation:6
            leftPadding: 0
            rightPadding: 0
            topPadding: 0
            bottomPadding: 0

            ItemDelegate {
                anchors.fill: parent

                onClicked: {
                    switch(model.index) {
                    case 0:
                        spManager.append(snackbar_page)
                        break;
                    case 1:
                        spManager.append(snackbar_page)
                        break;
                    case 2:
                        spManager.append(snackbar_page)
                        break;
                    }
                }

                Column {
                    id:content
                    width: parent.width
                    anchors.margins: 12 * Devices.density
                    anchors.centerIn: parent

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        scale: 1/Devices.density
                        font.pixelSize: 26 * Devices.fontDensity
                        font.family: materialDesignIcons.name
                        text: model.icon
                        color: Material.primary
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 14 * Devices.fontDensity
                        font.family: globalFontName
                        text: model.name
                        color: Material.primary
                    }
                }
            }
        }
    }

    Header {
        id:header
        width: parent.width
        color: Material.primary
        text: app.applicationName
        centerText: false
        titleFont: globalFontName
        titleFontSize: 12 * Devices.fontDensity
    }

    Component {
        id: snackbar_page
        SnackBarPage {
            anchors.fill: parent
        }
    }
}

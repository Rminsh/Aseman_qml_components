import QtQuick 2.9
import QtQuick.Window 2.2
import AsemanTools 1.1
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../Toolkit"

Page {

    Column {

        width: parent.width /2
        anchors.centerIn: parent

        TextField {
            id: showLabel
            width: parent.width
            placeholderText: qsTr("Enter your text")
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "open"
            highlighted: true
            onClicked: showLabel.text == "" ? snackbar.open("Text field is empty") : snackbar.open(showLabel.text)
        }
    }

    Snackbar {
        id: snackbar
    }

    Header {
        id:header
        width: parent.width
        color: Material.primary
        text: "Snackbar"
        centerText: false
        titleFont: globalFontName
        titleFontSize: 12 * Devices.fontDensity
    }
}

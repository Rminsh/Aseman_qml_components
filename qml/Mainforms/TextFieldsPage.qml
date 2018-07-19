import QtQuick 2.9
import QtQuick.Window 2.2
import AsemanTools 1.1
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../Toolkit"

Page {

    TextField {
        width: parent.width/2
        anchors.centerIn: parent
        helperText: "hint"
    }

    Header {
        id:header
        width: parent.width
        color: Material.primary
        text: "TextFields"
        centerText: false
        titleFont: globalFontName
        titleFontSize: 12 * Devices.fontDensity
    }
}

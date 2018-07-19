import QtQuick 2.9
import QtQuick.Layouts 1.3
import AsemanTools 1.1
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    id: control
    implicitWidth: input.contentWidth
    implicitHeight: Math.max(input.contentHeight + 32 * Devices.density, 48 * Devices.density)

    property alias text: input.text
    property string textColor: "#de000000"
    property color selectColor: Material.accent
    property alias length: input.length
    property alias maxLength: input.maximumLength

    property string fontFamily: AsemanApp.globalFont.family

    property string helperText: ""
    property string helperTextColorDeactive: "#BABABA"
    property string helperTextColorActive: Material.accent
    property bool floatingLabel: false

    TextInput {
        id: input
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: underline.top
            topMargin: 18 * Devices.density
        }
        color: textColor
        selectionColor: selectColor
        font.family: fontFamily
        font.pointSize: 12 * Devices.fontDensity
    }

    Rectangle {
        id: underline
        color: input.activeFocus && input.text !== "" ? helperTextColorActive : helperTextColorDeactive

        height: input.activeFocus ? 2 * Devices.density : 1 * Devices.density

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }


    Label {
        id: fieldPlaceholder

        anchors.verticalCenter: parent.verticalCenter
        text: helperText
        font.family: fontFamily
        font.pixelSize: 16 * Devices.density
        anchors.margins: -12 * Devices.density
        color: input.activeFocus && input.text !== "" ? helperTextColorActive : helperTextColorDeactive

        states: [
            State {
                name: "floating"
                when: input.length > 0
                AnchorChanges {
                    target: fieldPlaceholder
                    anchors.verticalCenter: undefined
                    anchors.top: parent.top
                }
                PropertyChanges {
                    target: fieldPlaceholder
                    font.pixelSize: 12 * Devices.density
                }
            },
            State {
                name: "hidden"
                when: input.length > 0 && !floatingLabel
                PropertyChanges {
                    target: fieldPlaceholder
                    visible: false
                }
            }
        ]

        transitions: [
            Transition {
                id: floatingTransition
                enabled: false
                AnchorAnimation {
                    duration: 200
                }
                NumberAnimation {
                    duration: 200
                    property: "font.pixelSize"
                }
            }
        ]

        Component.onCompleted: floatingTransition.enabled = true
    }
}

import AsemanTools 1.1
import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../Toolkit"

AsemanWindow {
    id: mainWin
    width: 500
    height: 768
    visible: true

    property string globalFontName: main_font.name

    property alias pageManager: spManager

    FontLoader { id: materialDesignIcons;  source: "../fonts/materialdesignicons-webfont.ttf" }
    FontLoader { id: main_font;            source: "../fonts/TitilliumWeb-Regular.ttf" }

    SlidePageManager {
        id: spManager
        anchors.fill: parent

        mainComponent: Item {
            anchors.fill: parent

            MainPage {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
            }

        }
    }

    Snackbar {
        id:snackbar
        duration: 1500
        alignRight: true
        color: Material.accent
        textColor: "white"
        fontFamily: globalFontName
    }

    SideMenu {
        id: sidebar
        anchors.fill: parent
        source: spManager
        menuType: menuTypeMaterial
        delegate: Rectangle {
            anchors.fill: parent

            LayoutMirroring.enabled: View.reverseLayout
            LayoutMirroring.childrenInherit: true

            ListModel {
                id: drawerModel
                function refresh() {
                    clear()
                    append( { "label": qsTr("Settings")      , "icon":"\uf8ba"})
                    append( { "label": qsTr("About")         , "icon":"\uf2fd"})
                }
                Component.onCompleted: refresh()
            }

            Connections {
                target: translationManager
                onRefresherChanged: drawerModel.refresh()
            }


            Column {
                anchors.fill: parent
                Image {
                    id: menu_cover
                    width: parent.width
                    height: width * 9/14 * Devices.density
                    source: "../images/Rocket.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectCrop
                    sourceSize: Qt.size(width*2,height*2)
                }

                Repeater {
                    width: parent.width
                    model: drawerModel
                    delegate: ItemDelegate {
                        id:menuItem
                        width: parent.width
                        onClicked: {
                            sidebar.discard()
                            switch(index) {
                                case 0:
//                                    spManager.append(settings_page)
                                    break;
                                case 1:
//                                    spManager.append(about_page);
                                    break;
                            }
                        }

                        Row {
                            spacing: 32 * Devices.density
                            anchors.fill: parent
                            anchors.leftMargin: 16 * Devices.density

                            Text {
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 16 * Devices.fontDensity
                                font.family: materialDesignIcons.name
                                color: Material.primary
                                text: model.icon
                            }

                            Text {
                                text: model.label
                                font.family: globalFontName
                                font.pixelSize: 10 * Devices.fontDensity
                                anchors.verticalCenter: parent.verticalCenter
                                color: Material.primary
                            }
                        }
                    }
                }
            }
        }
    }

    HeaderMenuButton {
        id:headerMenuButton
        onClicked: {
            if(spManager.count)
                BackHandler.back()
            else
            if(sidebar.showed)
                sidebar.discard()
            else
                sidebar.show()
        }

        ratio: {
            if(spManager.count)
                return fakeRatio
            else
            if(sidebar.percent == 0)
                return fakeRatio
            return sidebar.percent
        }

        property real fakeRatio: {
            if(spManager.count)
                return 1
            else
                return 0
        }

        Behavior on fakeRatio {
            NumberAnimation{easing.type: Easing.OutCubic; duration: 300}
        }
    }

}

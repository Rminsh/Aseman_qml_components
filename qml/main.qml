import QtQuick 2.7
import AsemanTools 1.1
import "."

AsemanApplication {
    id: app
    applicationName: "Aseman Qml Components"
    applicationAbout: "Aseman Qml Components"
    applicationDisplayName: "Aseman Qml Components"
    applicationVersion: "1.0.0"
    organizationDomain: "aseman.co"
    organizationName: "Aseman Team"
    source: "Mainforms/MainWindow.qml"

    Component.onCompleted: {
        View.layoutDirection = Qt.LeftToRight
    }

    Settings {
        id: _languageSettings
        source: AsemanApp.homePath + "/language.ini"
        category: "General"

        property string localeName: "en"
    }

    TranslationManager {
        id: translationManager
        sourceDirectory: "translations"
        delimiters: "-"
        fileName: "lang"
        localeName: _languageSettings.localeName

        function refreshLayouts() {
            View.layoutDirection = textDirection
            if(localeName == "fa")
                CalendarConv.calendar = 1
            else
                CalendarConv.calendar = 0
        }
        Component.onCompleted: refreshLayouts()
        onLocaleNameChanged: refreshLayouts()
    }
}

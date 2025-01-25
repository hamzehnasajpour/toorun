import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.WebSockets 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    title: qsTr("Websocket Server")
    width: 640
    height: 480
    signal buttonClicked(string message)

    property int buttonWidth: 200
    Column {
        x: 5
        y: 5
        width: parent.width - 10
        height: parent.height
        spacing: 10
        anchors.margins: 5

        Button {
            width: buttonWidth
            anchors.centerIn: parent.Center
            text: "Websocket Client"
            onClicked: {
                buttonClicked("websocketclient");
            }
        }

        Button {
            width: buttonWidth
            anchors.centerIn: parent.Center
            text: "Websocket Server"
            onClicked: {
                buttonClicked("websocketserver");
            }
        }
    }
}

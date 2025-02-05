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
        height: implicitHeight
        anchors.centerIn: parent
        spacing: 10
        Row {
            spacing: 10
            Button {
                width: 2*buttonWidth + 10
                text: "MQTT Publisher/Subscriber"
                onClicked: {
                    buttonClicked("mqttpubsub");
                }
            }
        }

        Row {
            spacing: 10
            Button {
                width: buttonWidth
                text: "Websocket Client"
                onClicked: {
                    buttonClicked("websocketclient");
                }
            }

            Button {
                width: buttonWidth
                text: "Websocket Server"
                onClicked: {
                    buttonClicked("websocketserver");
                }
            }
        }

        Row {
            spacing: 10
            Button {
                width: buttonWidth
                text: "Multicast Receiver"
                onClicked: {
                    buttonClicked("multicastreceiver");
                }
            }
            Button {
                width: buttonWidth
                text: "Multicast Sender"
                onClicked: {
                    buttonClicked("multicastsender");
                }
            }
        }
    }
}

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.WebSockets 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    property string applicationVersion : "1.0"
    property string applicationName: "TooRun"

    title: applicationName + " - (" + applicationVersion + ")"
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

//        Row {
//            spacing: 10
//            Button {
//                width: 2*buttonWidth + 10
//                text: "TCP Connection"
//                onClicked: {
//                    buttonClicked("tcp");
//                }
//            }
//        }

        Row {
            spacing: 10
            Button {
                width: 2*buttonWidth + 10
                text: "UDP Connection"
                onClicked: {
                    buttonClicked("udp");
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
                text: "Multicast Sender"
                onClicked: {
                    buttonClicked("multicastsender");
                }
            }
            Button {
                width: buttonWidth
                text: "Multicast Receiver"
                onClicked: {
                    buttonClicked("multicastreceiver");
                }
            }
        }
    }
}

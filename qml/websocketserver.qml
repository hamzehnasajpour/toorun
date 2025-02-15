import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.WebSockets 1.0
import QtQuick.Layouts 1.1

GwWindow {
    id: mainWindow
    title: qsTr("Websocket Server")

    WebSocketServer {
        id: server
        listen: false
        port: 1234
        onClientConnected: {
            webSocket.onTextMessageReceived.connect(function(message) {
                appendToReceived(message, receiveTextArea, showAsHex.checked);
                if(sendTextArea.text)
                    webSocket.sendTextMessage(sendAsHex.checked?stringToHex(sendTextArea.text):sendTextArea.text);
            });
        }
        onErrorStringChanged: {
            appendToReceived(qsTr("Server error: %1").arg(errorString), receiveTextArea, false);
        }
        onListenChanged: {
            connectionButton.text=server.listen?qsTr("Stop"):qsTr("Listen")
        }
    }

    ColumnLayout {
        x: 5
        y: 5
        anchors.fill: parent
        spacing: 5
        anchors.margins: 5
        Row {
            spacing: 10
            Text {
                text: "Port:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: portField
                placeholderText: qsTr("1234")
                text: qsTr("1234")
                width: 100
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                id: connectionButton
                text: server.listen?qsTr("Stop"):qsTr("Listen")
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    server.port = Number(portField.text);
                    server.listen = !server.listen
                }
            }
        }

        TextArea {
            id: sendTextArea
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Row {
            spacing: 10
            CheckBox {
                id: sendAsHex
                text: "Send as HEX"
                checked: false
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                text: qsTr("Clear")
                onClicked: {
                    sendTextArea.text="";
                }
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        TextArea {
            id: receiveTextArea
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            readOnly: true
        }
        Row {
            spacing: 10
            CheckBox {
                id: showAsHex
                text: "Receive as HEX"
                checked: false
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                text: qsTr("Clear")
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    receiveTextArea.text="";
                }
            }
        }
    }
}

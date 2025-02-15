import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.WebSockets 1.0
import QtQuick.Layouts 1.1

GwWindow {
    id: mainWindow
    title: qsTr("Websocket Client")

    WebSocket {
        id: socket
        onTextMessageReceived: {
            appendToReceived(message, receiveTextArea, showAsHex.checked);
            textSizeField.text = receiveTextArea.text.length + "/" + maxTextBufferSize;
        }
        onStatusChanged: {
            console.log("websocketclient onStatusChanged:" + socket.status)
            if (socket.status == WebSocket.Open) {
                sendButton.enabled=true;
                connectionButton.text="Disconnect";
            } else {
                sendButton.enabled=false;
                connectionButton.text="Connect";
                if (socket.status == WebSocket.Error) {
                    console.log("Error: " + socket.errorString)
                } else if (socket.status == WebSocket.Closed) {
                    console.log("Socket closed")
                }
            }
        }
        onErrorStringChanged: {
            console.log("websocketclient onStatusChanged:" + errorString)
        }
        active: true
    }

    Timer {
        // workaround to fix the issue for the first connection
        id: resetTimer
        interval: 500 // 500ms
        running: false
        repeat: false
        onTriggered: socket.active = false
    }

    ColumnLayout {
        x: 5
        y: 5
        anchors.fill: parent
        spacing: 5
        anchors.margins: 5
        Row {
            spacing: 5
            Text {
                text: "IP:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: ipField
                readOnly: (socket.status == WebSocket.Open)
                text: qsTr("ws://127.0.0.1:1234/")
                placeholderText: qsTr("ws://127.0.0.1:1234/")
                width: 200
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                id: connectionButton
                text: (socket.status == WebSocket.Open)?qsTr("Disconnect"):qsTr("Connect")
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    socket.url = ipField.text;
                    if(socket.status == WebSocket.Open)
                        socket.active = !socket.active;
                    else
                        socket.active = true;
                }
            }
        }

        TextArea {
            id: sendTextArea
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillHeight: parent
            Layout.fillWidth: parent
        }

        Row {
            spacing: 5
            CheckBox {
                id: sendAsHex
                text: "Send As HEX"
                checked: false
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                id: sendButton
                text: qsTr("Send")
                enabled: (socket.status == WebSocket.Open)
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    socket.sendTextMessage(sendAsHex.checked?stringToHex(sendTextArea.text):sendTextArea.text);
                }
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
            Layout.fillHeight: parent
            Layout.fillWidth: parent
            readOnly: true
        }
        Row {
            spacing: 5
            CheckBox {
                id: showAsHex
                text: "Show As HEX"
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
            Text {
                id: textSizeField
            }
        }
    }
}

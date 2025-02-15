import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

GwWindow {
    id: mainWindow
    property string connectionname: ""
    property bool isConnected: false

    signal stop();
    signal listen(int port);
    signal send(string ip, int port, string message);

    title: qsTr(connectionname + " Connection")

    function onReceivedData(data){
        appendToReceived(data, receiveTextArea, showAsHex.checked);
        textSizeField.text = receiveTextArea.text.length + "/" + maxTextBufferSize;
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
                text: connectionname + " RX PORT:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: rxPortField
                readOnly: isConnected
                text: qsTr("1234")
                placeholderText: qsTr("1234")
                width: 200
                anchors.verticalCenter: parent.verticalCenter
            }
            CheckBox {
                id: showAsHex
                text: "Show As HEX"
                enabled: isConnected
                checked: false
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                id: connectionButton
                text: isConnected?qsTr("Stop"):qsTr("Listen")
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    if(isConnected)
                        stop();
                    else
                        listen(rxPortField.text);
                }
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
            Text {
                text: "IP:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: ipField
                text: qsTr("127.0.0.1")
                placeholderText: qsTr("127.0.0.1")
                width: 200
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: connectionname + " TX PORT:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: txPortField
                text: qsTr("4321")
                placeholderText: qsTr("4321")
                width: 200
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                id: sendButton
                text: qsTr("Send")
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    if(ipField.text && txPortField.text) {
                        send(ipField.text, txPortField.text,
                                sendAsHex.checked?stringToHex(sendTextArea.text):sendTextArea.text);
                    }
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

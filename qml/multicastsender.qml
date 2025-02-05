import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.WebSockets 1.0
import gw.siosepol.multicast 1.0

GwWindow {
    id: mainWindow
    title: qsTr("Multicast Sender")

    MulticastSender {
        id: multicastSender
    }

    Column {
        x: 5
        y: 5
        width: parent.width - 10
        height: parent.height
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
                placeholderText: qsTr("239.2.1.1")
                text: qsTr("239.2.1.1")
                anchors.verticalCenter: parent.verticalCenter
                width: 200
            }
            Text {
                text: "Port:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: portField
                placeholderText: qsTr("2054")
                text: qsTr("2054")
                width: 100
                anchors.verticalCenter: parent.verticalCenter
            }
            CheckBox {
                id: hexCheckBox
                text: "Send As HEX"
                checked: false
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                id: sendButton
                text: qsTr("Send")
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    multicastSender.sendDatagram(ipField.text, parseInt(portField.text),
                                    (hexCheckBox.checked?stringToHex(sendTextArea.text):
                                                         sendTextArea.text));
                }
            }
        }

        TextArea {
            id: sendTextArea
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height - 75
        }
        Button {
            text: qsTr("Clear")
            onClicked: {
                receiveTextArea.text="";
            }
        }
    }
}

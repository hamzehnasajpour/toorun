import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.WebSockets 1.0
import gw.peyvand.multicast 1.0

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
        spacing: 10
        anchors.margins: 5
        Row {
            spacing: 10
            Text {
                text: "IP:"
            }
            TextField {
                id: ipField
                placeholderText: qsTr("239.2.1.1")
                text: qsTr("239.2.1.1")
                width: 400
            }
            Text {
                text: "Port:"
            }
            TextField {
                id: portField
                placeholderText: qsTr("2054")
                text: qsTr("2054")
                width: 100
            }
            Button {
                id: sendButton
                text: qsTr("Send")
                onClicked: {
                    multicastSender.sendDatagram(ipField.text, parseInt(portField.text), sendTextArea.text)
                }
            }
        }

        TextArea {
            id: sendTextArea
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height - 25
        }
        Button {
            text: qsTr("Clear")
            onClicked: {
                receiveTextArea.text="";
            }
        }
    }
}

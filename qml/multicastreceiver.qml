import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.WebSockets 1.0
import gw.siosepol.multicast 1.0

GwWindow {
    id: mainWindow
    title: qsTr("Multicast Receiver")

    MulticastReceiver {
        id: multicastReceiver
        onReceivedDatagram: appendToReceived(data);
    }

    function appendToReceived(message) {
        receiveTextArea.text = Qt.formatDateTime(new Date(), "yyyyMMdd hh:mm:ss") +
                                " - " + (hexCheckBox.checked?hexToString(message):message) +
                                "\n" + receiveTextArea.text;
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
                anchors.verticalCenter: parent.verticalCenter
                width: 100
            }
            CheckBox {
                id: hexCheckBox
                text: "Show As HEX"
                anchors.verticalCenter: parent.verticalCenter
                checked: false
            }
            Button {
                id: connectionButton
                text: multicastReceiver.isConnected?qsTr("Stop"):qsTr("Listen")
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    if(multicastReceiver.isConnected)
                    {
                        multicastReceiver.close();
                    }
                    else
                    {
                        multicastReceiver.open(ipField.text, parseInt(portField.text));
                    }
                }
            }
        }

        TextArea {
            id: receiveTextArea
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height - 75
            readOnly: true
        }
        Button {
            text: qsTr("Clear")
            onClicked: {
                receiveTextArea.text="";
            }
        }
    }
}

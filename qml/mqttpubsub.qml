import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

GwWindow {
    title: qsTr("MQTT Publisher/Subscriber")
    Row {
        id: firstRow
        spacing: 10
        Text {
            text: "ADDRESS:"
        }
        TextField {
            id: ipField
            placeholderText: qsTr("mqtt://192.168.0.54")
            text: qsTr("mqtt://192.168.0.54")
            width: 200
        }
        Text {
            text: "Port:"
        }
        TextField {
            id: portField
            placeholderText: qsTr("1883")
            text: qsTr("1883")
            width: 100
        }
        Text {
            text: "Subscription:"
        }
        TextField {
            id: subscriptionField
            placeholderText: qsTr("#")
            text: qsTr("#")
            width: 100
        }
        CheckBox {
            id: hexCheckBox
            text: "Show As HEX"
            checked: false
            enabled: !mqttClient.isConnected
            onCheckedChanged: {
                mqttClient.dataAsHex(checked);
            }
        }
        Button {
            id: connectionButton
            text: mqttClient.isConnected?qsTr("Stop"):qsTr("Listen")
            onClicked: {
                if(mqttClient.isConnected)
                {
                    mqttClient.disconnectFromHost();
                }
                else
                {
                    mqttClient.connectToHost(ipField.text, portField.text, subscriptionField.text);
                }
            }
        }
    }
    TreeView {
        width: parent.width
        height: parent.height - firstRow.height
        anchors.top: firstRow.bottom
        model: mqttTreeModel
        itemDelegate: TreeDelegate {}

        TableViewColumn {
            role: "topic"
            title: "Topic"
            width: 400
        }

        TableViewColumn {
            role: "message"
            title: "Message"
            width: 800
        }
    }
}

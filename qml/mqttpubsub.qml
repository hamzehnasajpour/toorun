import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

GwWindow {
    title: qsTr("MQTT Publisher/Subscriber")
    Column {
        x: 5
        y: 5
        width: parent.width - 10
        height: parent.height
        spacing: 5
        anchors.margins: 5
        Row {
            spacing: 5
            anchors.margins: 5
            Text {
                text: "ADDRESS:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: ipField
                placeholderText: qsTr("mqtt://192.168.0.54")
                text: qsTr("mqtt://192.168.0.54")
                anchors.verticalCenter: parent.verticalCenter
                width: 200
            }
            Text {
                text: "Port:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: portField
                placeholderText: qsTr("1883")
                text: qsTr("1883")
                anchors.verticalCenter: parent.verticalCenter
                width: 100
            }
            Text {
                text: "Subscription:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: subscriptionField
                placeholderText: qsTr("#")
                text: qsTr("#")
                width: 100
                anchors.verticalCenter: parent.verticalCenter
            }
            CheckBox {
                id: hexCheckBox
                text: "Show As HEX"
                checked: false
                enabled: !mqttClient.isConnected
                anchors.verticalCenter: parent.verticalCenter
                onCheckedChanged: {
                    mqttClient.dataAsHex(checked);
                }
            }
            Button {
                id: connectionButton
                text: mqttClient.isConnected?qsTr("Stop"):qsTr("Listen")
                anchors.verticalCenter: parent.verticalCenter
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
            height: parent.height - 50
            model: mqttTreeModel
            itemDelegate: TreeDelegate {}

            TableViewColumn {
                role: "topic"
                title: "Topic/Message"
            }
        }
    }
}

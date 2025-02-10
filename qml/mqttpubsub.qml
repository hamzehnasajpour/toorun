import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

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
                enabled: !mqttClient.isConnected
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
                enabled: !mqttClient.isConnected
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
                enabled: !mqttClient.isConnected
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
        Rectangle {
            height: 1
            color: "gray"
            width: parent.width
        }
        Row {
            spacing: 5
            anchors.margins: 5
            TextField {
                id: topicFieldPublish
                placeholderText: qsTr("topic, ex:topic1/test")
                enabled: mqttClient.isConnected
                width: 400
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id: messageFieldPublish
                placeholderText: qsTr("message...")
                enabled: mqttClient.isConnected
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
            }
            CheckBox {
                id: sendAsHex
                text: "Send As HEX"
                checked: false
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                id: publishButton
                text: qsTr("Publish")
                enabled: mqttClient.isConnected
                anchors.verticalCenter: parent.verticalCenter
                Layout.preferredWidth: 80
                Layout.preferredHeight: 40
                onClicked: {
                    if(topicFieldPublish.text && messageFieldPublish.text){
                        mqttClient.sendMessage(topicFieldPublish.text,
                                               (sendAsHex.checked?stringToHex(messageFieldPublish.text):messageFieldPublish.text));
                    }
                }
            }
        }
        Rectangle {
            height: 1
            color: "gray"
            width: parent.width
        }

        TreeView {
            width: parent.width
            height: parent.height - 150
            model: mqttTreeModel
            itemDelegate: TreeDelegate {}

            TableViewColumn {
                role: "topic"
                title: "Topic/Message"
            }
        }
    }
}

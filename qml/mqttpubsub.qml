import QtQuick 2.5
import QtQuick.Controls 1.4

GwWindow {
    title: qsTr("MQTT Publisher")

    Column {
        anchors.centerIn: parent
        spacing: 10

        TextField {
            id: ipField
            placeholderText: "Enter MQTT Broker IP"
        }

        TextField {
            id: portField
            placeholderText: "Enter Port (Default: 1883)"
            text: "1883"
        }

        TextField {
            id: topicField
            placeholderText: "Enter Topic"
        }

        TextField {
            id: messageField
            placeholderText: "Enter Message"
        }

        Button {
            text: "Publish"
            onClicked: {
                mqttBridge.publishMessage(ipField.text, portField.text, topicField.text, messageField.text)
            }
        }
    }
}

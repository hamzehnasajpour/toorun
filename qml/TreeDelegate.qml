import QtQuick 2.0
import gw.siosepol.mqtt 1.0

Item {
    Text {
        id: topicText
        width: 400
        color: styleData.textColor
        elide: styleData.elideMode
//        font.pointSize: 14
        text: (styleData.value?styleData.value.topic:"")
    }
    Text {
        id: messageText
        width: 800
        anchors.left: topicText.right
        color: styleData.textColor
        elide: styleData.elideMode
//        font.pointSize: 14
        text: (styleData.value?styleData.value.message:"")
    }
}

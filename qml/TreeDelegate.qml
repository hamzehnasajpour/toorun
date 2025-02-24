import QtQuick 2.0
import gw.siosepol.mqtt 1.0

Item {
    TextEdit {
        id: topicText
        color: styleData.textColor
//        elide: styleData.elideMode
//        font.pointSize: 14
        readOnly: true
        selectByMouse: true
        text: (styleData.value?styleData.value.topic:"")
    }

    TextEdit {
        id: messageText
        anchors.leftMargin: 40
        anchors.left: topicText.right
        color: styleData.textColor
        readOnly: true
        selectByMouse: true
//        elide: styleData.elideMode
//        font.pointSize: 14
        text: (styleData.value?styleData.value.message:"")
    }
}

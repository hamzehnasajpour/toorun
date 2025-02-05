import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Window {
    id: mainWindow
    width: 1024
    height: 768
    visible: true
//    visibility: Window.Maximized
    property string applicationVersion : "1.0"
    property string applicationName: "Si-o-se Pol (33 arches)"

    function stringToHex(hexString) {
        if (hexString.length % 2 !== 0) {
            console.log("Invalid input length");
            return "";
        }

        var result = "";
        for (var i = 0; i < hexString.length; i += 2) {
            var hexValue = parseInt(hexString.substring(i, i + 2), 16);
            result += String.fromCharCode(hexValue);
        }
        return result;
    }

    function hexToString(message){
        var hexString = "";
        for (var i = 0; i < message.length; i++) {
            hexString += "0x" + message.charCodeAt(i).toString(16) + " ";
        }
        return hexString.trim();
    }
}

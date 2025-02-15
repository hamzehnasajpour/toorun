import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import gw.siosepol.udp 1.0

UdpTcpWindow {
    id: udpwindow
    connectionname: qsTr("UDP")
    isConnected: udpconnection.isConnected

    Udp {
        id: udpconnection
        onReceivedDatagram: udpwindow.onReceivedData(data)
    }

    onStop:{
            udpconnection.stop();
    }

    onListen: {
        udpconnection.listen(port);
    }

    onSend: {
        udpconnection.sendDatagram(ip, port,message);
    }

}

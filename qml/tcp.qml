import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import gw.siosepol.tcp 1.0

UdpTcpWindow {
    id: tcpwindow
    connectionname: qsTr("TCP")
    isConnected: tcpconnection.isConnected

    Tcp {
        id: tcpconnection
        onReceived: tcpwindow.onReceivedData(data)
    }

    onStop:{
            tcpconnection.stop();
    }

    onListen: {
        tcpconnection.listen(port);
    }

    onSend: {
        tcpconnection.sendDatagram(ip, port,message);
    }

}

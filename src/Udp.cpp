#include "Udp.h"

Udp::Udp(QObject *parent) : QObject(parent)
{
}

void Udp::sendDatagram(QString ip, int port, QString message){
    QByteArray datagram = message.toUtf8();
    m_udpSocket4.writeDatagram(datagram, QHostAddress(ip), port);
    qDebug() << "UdpClient: Sending datagram to"
             << ip
             << "on port" << port
             << "with data" << message;
}

void Udp::listen(const quint16 rxport){
    connect(&m_udpSocket4, &QUdpSocket::readyRead, this, &Udp::processPendingDatagrams);
    m_udpSocket4.bind(QHostAddress(QHostAddress::AnyIPv4), rxport);
    qDebug() << "UdpClient: Ready to listen on port" << rxport;
    m_isConnected = true;
    emit isConnectedChanged();
}

void Udp::stop(){
    m_udpSocket4.close();
    disconnect(&m_udpSocket4);
    m_isConnected = false;
    emit isConnectedChanged();
}

bool Udp::isConnected() const{
    return m_isConnected;
}

void Udp::processPendingDatagrams(){
    QByteArray datagram;
    QHostAddress sender;
    while (m_udpSocket4.hasPendingDatagrams()) {
        datagram.resize(m_udpSocket4.pendingDatagramSize());
        quint16 senderPort;

        m_udpSocket4.readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);
        emit receivedDatagram(sender.toString(), QString::fromUtf8(datagram));

        qDebug() << "UdpClient: Received datagram from"
                 << sender.toString()
                 << "on port" << senderPort
                 << "with data" << datagram;
    }
}

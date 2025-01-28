#include "Multicast.h"
#include <QDebug>

MulticastSender::MulticastSender(QObject *parent)
    : QObject(parent)
{
}

void MulticastSender::startSending()
{
    timer.start(5000);
}

void MulticastSender::sendDatagram(QString ip, int port, QString message)
{
    groupAddress4 = ip,
    udpSocket4.bind(QHostAddress(QHostAddress::AnyIPv4), port);
    udpSocket4.setSocketOption(QAbstractSocket::MulticastTtlOption, 2);

    qDebug() << "MulticastSender: Ready to multicast datagrams to groups"
             << groupAddress4.toString()
             << "on port" << port;

    QByteArray datagram = message.toUtf8();
    udpSocket4.writeDatagram(datagram, groupAddress4, port);
    udpSocket4.close();
}

MulticastReceiver::MulticastReceiver(QObject *parent)
    : QObject(parent)
{
}

void MulticastReceiver::open(QString ip, int port)
{
    groupAddress4 = ip;
    udpSocket4.bind(QHostAddress::AnyIPv4, port, QUdpSocket::ShareAddress);
    udpSocket4.joinMulticastGroup(groupAddress4);
    qDebug() << "MulticastReceiver: Ready to receive datagrams from groups"
             << groupAddress4.toString()
             << "on port" << port;
    connect(&udpSocket4, &QUdpSocket::readyRead,
            this, &MulticastReceiver::processPendingDatagrams);
    m_isConnected = true;
    emit isConnectedChanged();
}

void MulticastReceiver::close()
{
    udpSocket4.close();
    m_isConnected = false;
    emit isConnectedChanged();
}

bool MulticastReceiver::isConnected() const
{
    return m_isConnected;
}

void MulticastReceiver::processPendingDatagrams()
{
    QByteArray datagram;
    // using QUdpSocket::readDatagram (API since Qt 4)
    while (udpSocket4.hasPendingDatagrams()) {
        datagram.resize(udpSocket4.pendingDatagramSize());
//        datagram.resize(qsizetype(udpSocket4.pendingDatagramSize()));
        udpSocket4.readDatagram(datagram.data(), datagram.size());
        emit receivedDatagram(datagram);
        qDebug() << "MulticastReceiver: Received datagram: " << datagram;
    }
}

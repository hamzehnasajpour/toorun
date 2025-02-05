#include "Multicast.h"
#include <QDebug>

MulticastSender::MulticastSender(QObject *parent)
    : QObject(parent)
{
}

void MulticastSender::startSending()
{
    m_timer.start(5000);
}

void MulticastSender::sendDatagram(QString ip, int port, QString message)
{
    m_groupAddress4 = ip,
    m_udpSocket4.bind(QHostAddress(QHostAddress::AnyIPv4), port);
    m_udpSocket4.setSocketOption(QAbstractSocket::MulticastTtlOption, 2);

    qDebug() << "MulticastSender: Ready to multicast datagrams to groups"
             << m_groupAddress4.toString()
             << "on port" << port;

    QByteArray datagram = message.toUtf8();
    m_udpSocket4.writeDatagram(datagram, m_groupAddress4, port);
    m_udpSocket4.close();
}

MulticastReceiver::MulticastReceiver(QObject *parent)
    : QObject(parent)
{
}

void MulticastReceiver::open(QString ip, int port)
{
    m_groupAddress4 = ip;
    m_udpSocket4.bind(QHostAddress::AnyIPv4, port, QUdpSocket::ShareAddress);
    m_udpSocket4.joinMulticastGroup(m_groupAddress4);
    qDebug() << "MulticastReceiver: Ready to receive datagrams from groups"
             << m_groupAddress4.toString()
             << "on port" << port;
    connect(&m_udpSocket4, &QUdpSocket::readyRead,
            this, &MulticastReceiver::processPendingDatagrams);
    m_isConnected = true;
    emit isConnectedChanged();
}

void MulticastReceiver::close()
{
    m_udpSocket4.close();
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
    while (m_udpSocket4.hasPendingDatagrams()) {
        datagram.resize(m_udpSocket4.pendingDatagramSize());
//        datagram.resize(qsizetype(udpSocket4.pendingDatagramSize()));
        m_udpSocket4.readDatagram(datagram.data(), datagram.size());
        emit receivedDatagram(datagram);
        qDebug() << "MulticastReceiver: Received datagram: " << datagram;
    }
}

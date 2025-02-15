#ifndef UDPCLIENT_H
#define UDPCLIENT_H

#include <QObject>
#include <QtNetwork>
#include <QtCore>
#include <QString>
#include <QHostAddress>
#include <QUdpSocket>

class Udp : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)

public:
    explicit Udp(QObject *parent = 0);

public slots:
    void sendDatagram(QString ip, int port, QString message);
    void listen(const quint16 rxport);
    void stop();
    bool isConnected() const;

private slots:
    void processPendingDatagrams();

signals:
    void receivedDatagram(QString sender, QString data);
    void isConnectedChanged();

private:
    QUdpSocket m_udpSocket4;
    QHostAddress m_ipAddress4;
    bool m_isConnected = false;
};

#endif // UDPCLIENT_H

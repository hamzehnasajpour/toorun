#ifndef MULTICAST_H
#define MULTICAST_H

#include <QObject>
#include <QtNetwork>
#include <QtCore>
#include <QString>
#include <QHostAddress>
#include <QUdpSocket>

class MulticastSender : public QObject
{
    Q_OBJECT

public:
    explicit MulticastSender(QObject *parent = nullptr);

public slots:
    void sendDatagram(QString ip, int port, QString message);

private slots:
    void startSending();

private:
    QUdpSocket m_udpSocket4;
    QTimer m_timer;
    QHostAddress m_groupAddress4;
    int m_messageNo = 1;
};

class MulticastReceiver : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)

public:
    explicit MulticastReceiver(QObject *parent = nullptr);
    bool isConnected() const;

public slots:
    void open(QString ip, int port);
    void close();

private slots:
    void processPendingDatagrams();

signals: 
    void receivedDatagram(QString data);
    void isConnectedChanged();

private:
    QUdpSocket m_udpSocket4;
    QHostAddress m_groupAddress4;
    bool m_isConnected = false;
};

#endif // MULTICAST_H

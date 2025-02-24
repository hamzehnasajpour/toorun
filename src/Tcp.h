#ifndef TCP_H
#define TCP_H

#include <QObject>
#include <QTcpSocket>
#include <QString>

class Tcp : public QObject
{
    Q_OBJECT

public:
    explicit Tcp(QObject *parent = nullptr);
    ~Tcp();

//     void connectToServer(const QString &host, quint16 port);
//     void disconnectFromServer();
//     void sendData(const QByteArray &data);

// signals:
//     void connected();
//     void disconnected();
//     void dataReceived(const QByteArray &data);
//     void errorOccurred(const QString &errorString);

// private slots:
//     void onConnected();
//     void onDisconnected();
//     void onReadyRead();
//     void onErrorOccurred(QAbstractSocket::SocketError socketError);

// private:
//     QTcpSocket *socket;
};

#endif // TCP_H
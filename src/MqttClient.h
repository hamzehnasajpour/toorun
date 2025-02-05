#ifndef MQTTCLIENT_H
#define MQTTCLIENT_H

#include <QObject>
#include "qmqtt.h"
#include "MqttTreeModel.h"

class MqttClient : public QMQTT::Client
{
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)

public:
    explicit MqttClient(QObject *parent = 0);
    void setModel(MqttTreeModel *model);

private slots:
    void onConnected();
    void onDisconnected();
    void onSubscribed(const QString &topic);
    void onReceived(const QMQTT::Message &message);
    void onError(const QMQTT::ClientError error);

signals:
    void isConnectedChanged();

public slots:
    void sendMessage(const QString &topic, const QString &message);
    void connectToHost(const QString &host, const quint16 port, const QString &subscription);
    bool isConnected() const;
    void dataAsHex(bool asHex);

private:
    MqttTreeModel *m_model;
    bool m_isConnected = false;
    bool m_dataAsHex = false;
    QString m_subscription="#";
};

#endif // MQTTCLIENT_H

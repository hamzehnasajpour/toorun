#include "MqttClient.h"
#include <QUrl>
#include <qmqtt/src/mqtt/qmqtt_message.h>
MqttClient::MqttClient(QObject *parent) : 
    QMQTT::Client(QHostAddress::LocalHost, 1883, parent){
//    setAutoReconnectInterval(2000);
//    setAutoReconnect(true);
    connect(this, &MqttClient::connected, this, &MqttClient::onConnected);
    connect(this, &MqttClient::disconnected, this, &MqttClient::onDisconnected);
    connect(this, &MqttClient::subscribed, this, &MqttClient::onSubscribed);
    connect(this, &MqttClient::received, this, &MqttClient::onReceived);
    connect(this, &MqttClient::error, this, &MqttClient::onError);
    connect(this, &MqttClient::published, this, &MqttClient::onPublished);
}

void MqttClient::sendMessage(const QString &topic, const QByteArray &message)
{
    QMQTT::Message qmttmessage(1, topic,message);
    publish(qmttmessage);
}

void MqttClient::onConnected()
{
    qDebug() << "MqttClient::onConnected";
    m_isConnected = true;
    if(m_model){
        m_model->clear();
    }
    emit isConnectedChanged();
    subscribe(m_subscription, 0);
}

void MqttClient::onDisconnected()
{
    qDebug() << "MessageBrokerClient::onDisconnected";
    m_isConnected = false;
    emit isConnectedChanged();
}

void MqttClient::onSubscribed(const QString &topic)
{
    qDebug() << "MessageBrokerClient::onSubscribed" << topic;
}

void MqttClient::onReceived(const QMQTT::Message &message)
{
    if(m_model){
        m_model->addTopic(message.topic(),(m_dataAsHex?message.payload().toHex():message.payload()));
    }
}

void MqttClient::onError(const QMQTT::ClientError error)
{
    qDebug() << "MessageBrokerClient::onError" << error;
}

void MqttClient::onPublished(const QMQTT::Message& message, quint16 msgid)
{
    Q_UNUSED(message);
    qDebug() << "MqttClient::onPublished:" << msgid;
}

void MqttClient::setModel(MqttTreeModel *model)
{
    m_model = model;
}

void MqttClient::connectToHost(const QString &host, const quint16 port, const QString &subscription)
{
    m_subscription = subscription;
    setHost(QHostAddress(QUrl(host).host()));
    setPort(port);
    QMQTT::Client::connectToHost();
}

bool MqttClient::isConnected() const
{
    return m_isConnected;
}

void MqttClient::dataAsHex(bool asHex)
{
    m_dataAsHex = asHex;
}

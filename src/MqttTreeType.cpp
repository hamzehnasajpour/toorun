#include "MqttTreeType.h"

MqttTreeType::MqttTreeType(QObject *parent) : QObject(parent), myIndentation(0)
{
}

MqttTreeType::MqttTreeType(const MqttTreeType &other)
{
    m_topic = other.m_topic;
    m_message = other.m_message;
    myIndentation = other.myIndentation;
}

MqttTreeType::~MqttTreeType()
{
}

QString MqttTreeType::topic()
{
    return m_topic;
}

void MqttTreeType::setTopic(QString topic)
{
    m_topic = topic;
    emit topicChanged();
}

QString MqttTreeType::message()
{
    return m_message;
}

void MqttTreeType::setMessage(QString message)
{
    m_message = message;
    emit messageChanged();
}

int MqttTreeType::indentation()
{
    return myIndentation;
}

void MqttTreeType::setIndentation(int indentation)
{
    myIndentation = indentation;
    emit indentationChanged();
}

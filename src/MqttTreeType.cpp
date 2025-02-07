#include "MqttTreeType.h"

MqttTreeType::MqttTreeType(QObject *parent) : QObject(parent), myIndentation(0)
{
}

MqttTreeType::MqttTreeType(const MqttTreeType &other)
{
    myText = other.myText;
    myIndentation = other.myIndentation;
}

MqttTreeType::~MqttTreeType()
{
}

QString MqttTreeType::text()
{
    return myText;
}

void MqttTreeType::setText(QString text)
{
    myText = text;
    emit textChanged();
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

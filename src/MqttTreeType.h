#ifndef MQTT_TREE_TYPE_H
#define MQTT_TREE_TYPE_H

#include <QObject>

class MqttTreeType : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(int indentation READ indentation WRITE setIndentation NOTIFY indentationChanged)

public:
    explicit MqttTreeType(QObject *parent = 0);
    MqttTreeType(const MqttTreeType &other);
    ~MqttTreeType();

    QString text();
    void setText(QString text);

    int indentation();
    void setIndentation(int indentation);

signals:
    void textChanged();
    void indentationChanged();

private:
    QString myText;
    int myIndentation;
};

Q_DECLARE_METATYPE(MqttTreeType)

#endif

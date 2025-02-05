#ifndef MQTT_TREE_TYPE_H
#define MQTT_TREE_TYPE_H

#include <QObject>

class MqttTreeType : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString topic READ topic WRITE setTopic NOTIFY topicChanged)
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)
    Q_PROPERTY(int indentation READ indentation WRITE setIndentation NOTIFY indentationChanged)

public:
    explicit MqttTreeType(QObject *parent = 0);
    MqttTreeType(const MqttTreeType &other);
    ~MqttTreeType();

    QString topic();
    void setTopic(QString topic);

    QString message();
    void setMessage(QString message);

    int indentation();
    void setIndentation(int indentation);

signals:
    void topicChanged();
    void messageChanged();
    void indentationChanged();

private:
    QString m_topic;
    QString m_message;
    int myIndentation;
};

Q_DECLARE_METATYPE(MqttTreeType)

#endif

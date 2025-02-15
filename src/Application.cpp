#include "Application.h"
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QFile>
#include <QQmlContext>
#include "MqttClient.h"
#include "MqttTreeModel.h"

void Application::openWindow(const QString &window){
    QString qmlFile = "qrc:/qml/main.qml";
    bool mainWindow = false;
    QQmlApplicationEngine *engine = new QQmlApplicationEngine();
    if (window == "websocketserver") {
        qmlFile = "qrc:/qml/websocketserver.qml";
    } else if (window == "websocketclient") {
        qmlFile = "qrc:/qml/websocketclient.qml";
    } else if (window == "udp") {
        qmlFile = "qrc:/qml/udp.qml";
    } else if (window == "tcp") {
        qmlFile = "qrc:/qml/tcp.qml";
    } else if (window == "multicastreceiver") {
        qmlFile = "qrc:/qml/multicastreceiver.qml";
    } else if (window == "multicastsender") {
        qmlFile = "qrc:/qml/multicastsender.qml";
    } else if (window == "mqttpubsub") {
        qmlFile = "qrc:/qml/mqttpubsub.qml";
        auto mqttTreeModel = new MqttTreeModel(this);

        MqttClient *mqttClient = new MqttClient(this);
        mqttClient->setModel(mqttTreeModel);
        engine->rootContext()->setContextProperty("mqttClient",mqttClient);
        engine->rootContext()->setContextProperty("mqttTreeModel",mqttTreeModel);
    } else {
        mainWindow = true;
    }

    qDebug() << "Opening window: " << qmlFile;
    engine->load(QUrl(qmlFile));
    if(mainWindow){
        QObject *rootObject = engine->rootObjects().first();
        QObject::connect(rootObject, SIGNAL(buttonClicked(QString)),
                         this,SLOT(openWindow(QString)));
    }
}

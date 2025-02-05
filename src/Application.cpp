#include "Application.h"
#include <QQmlApplicationEngine>
#include <QDebug>

void Application::openWindow(const QString &window){
    QString qmlFile = "qrc:/qml/main.qml";
    bool mainWindow = true;
    if (window == "websocketserver") {
        mainWindow = false;
        qmlFile = "qrc:/qml/websocketserver.qml";
    } else if (window == "websocketclient") {
        mainWindow = false;
        qmlFile = "qrc:/qml/websocketclient.qml";
    } else if (window == "multicastreceiver") {
        mainWindow = false;
        qmlFile = "qrc:/qml/multicastreceiver.qml";
    } else if (window == "multicastsender") {
        mainWindow = false;
        qmlFile = "qrc:/qml/multicastsender.qml";
    } else if (window == "mqttpubsub") {
        mainWindow = false;
        qmlFile = "qrc:/qml/mqttpubsub.qml";
    }
    qDebug() << "Opening window: " << qmlFile;
    
    QQmlApplicationEngine *engine = new QQmlApplicationEngine();
    engine->load(QUrl(qmlFile));
    if(mainWindow){
        QObject *rootObject = engine->rootObjects().first();
        QObject::connect(rootObject, SIGNAL(buttonClicked(QString)),
                         this,SLOT(openWindow(QString)));
    }
}

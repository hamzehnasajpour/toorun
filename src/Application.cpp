#include "Application.h"
#include <QQmlApplicationEngine>
#include <QDebug>

#define APP_VER "1.0"
#define APP_NAME "Peyvand"
#define APP_EXE_NAME "peyvand"

void Application::openWindow(const QString &window){
    QString qmlFile = "qrc:/qml/main.qml";
    bool mainWindow = true;
    if (window == "websocketserver") {
        mainWindow = false;
        qmlFile = "qrc:/qml/websocketserver.qml";
    } else if (window == "websocketclient") {
        mainWindow = false;
        qmlFile = "qrc:/qml/websocketclient.qml";
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

QString Application::version(){
    return APP_VER;
}

QString Application::applicationName(){
    return APP_NAME;
}

QString Application::applicationExecutableName(){
    return APP_EXE_NAME;
}

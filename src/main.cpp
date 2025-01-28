#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlEngine>
#include <QtQml>

#include "Application.h"
#include "Multicast.h"

Application capp;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QString arg;
    if (argc > 1) {
        arg = argv[1];
    }

    qmlRegisterType<MulticastSender>("gw.peyvand.multicast", 1, 0, "MulticastSender");
    qmlRegisterType<MulticastReceiver>("gw.peyvand.multicast", 1, 0, "MulticastReceiver");

    capp.openWindow(arg);
    return app.exec();
}

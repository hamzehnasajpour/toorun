#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include "Application.h"

Application capp;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QString arg;
    if (argc > 1) {
        arg = argv[1];
    }
    capp.openWindow(arg);
    return app.exec();
}

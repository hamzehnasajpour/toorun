#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlEngine>
#include <QtQml>
#include <QIcon>
#include <QSvgRenderer>
#include <QPainter>

#include "Application.h"
#include "Multicast.h"
#include "MqttTreeType.h"

Application capp;

class SvgIcon : public QIcon {
public:
    SvgIcon(const QString &fileName) {
        QSvgRenderer svgRenderer(fileName);
        QSize size(100, 100); // Set the desired size for the icon
        QPixmap pixmap(size);
        pixmap.fill(Qt::transparent);
        QPainter painter(&pixmap);
        svgRenderer.render(&painter);
        addPixmap(pixmap);
    }
};

int main(int argc, char *argv[])
{
    Q_INIT_RESOURCE(qml);

    QGuiApplication app(argc, argv);
    // setting svg icon on my app window
    app.setWindowIcon(SvgIcon(":/images/siosepol.svg"));

    QString arg;
    if (argc > 1) {
        arg = argv[1];
    }

    qmlRegisterType<MulticastSender>("gw.siosepol.multicast", 1, 0, "MulticastSender");
    qmlRegisterType<MulticastReceiver>("gw.siosepol.multicast", 1, 0, "MulticastReceiver");
    qmlRegisterType<MqttTreeType>("gw.siosepol.mqtt", 1, 0, "MqttTreeType");

    capp.openWindow(arg);
    return app.exec();
}

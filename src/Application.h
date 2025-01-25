#ifndef APPLICATION_H
#define APPLICATION_H

#include <QObject>

class Application : public QObject
{
    Q_OBJECT
public:

public slots:
    void openWindow(const QString &window);
    QString version();
    QString applicationName();
    QString applicationExecutableName();
};

#endif // APPLICATION_H

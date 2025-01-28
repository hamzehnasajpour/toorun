#ifndef APPLICATION_H
#define APPLICATION_H

#include <QObject>

class Application : public QObject
{
    Q_OBJECT
public:

public slots:
    void openWindow(const QString &window);
};

#endif // APPLICATION_H

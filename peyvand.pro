TEMPLATE = app

QT += qml quick websockets

CONFIG += c++11

SOURCES += src/main.cpp \ 
    src/Application.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = 

HEADERS += \
    src/Application.h

TEMPLATE = app

QT += qml quick websockets network

CONFIG += c++11

SOURCES += src/main.cpp \ 
    src/Application.cpp \
    src/Multicast.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = 

HEADERS += \
    src/Application.h \
    src/Multicast.h

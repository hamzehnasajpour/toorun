TEMPLATE = app

QT += qml quick network
#QT += websockets

CONFIG += c++14
#CONFIG += QMQTT_NO_SSL NO_UNIT_TESTS
#DEFINES += QT_WEBSOCKETS_LIB

SOURCES += src/main.cpp \ 
    src/Application.cpp \
    src/Multicast.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = 

HEADERS += \
    src/Application.h \
    src/Multicast.h

include(qmqtt/qmqtt.pri)

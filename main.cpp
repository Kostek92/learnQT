#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "PlayerController.h"

void registerMyQmls(QGuiApplication& app)
{
    auto* playerController = new PlayerController(&app);
    qmlRegisterSingletonInstance("com.company.PlayerController", 1, 0, "PlayerController", playerController);
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QIcon appIcon(":/Qml9_player/assets/icons/app_icon.ico");
    app.setWindowIcon(appIcon);

    registerMyQmls(app);

    const QUrl url(u"qrc:/Qml9_player/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

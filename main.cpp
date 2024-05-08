#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    // app.setWindowIcon(QIcon(":/image/titlelogo.png"));
    QQmlApplicationEngine engine;
    QQuickWindow::setGraphicsApi(QSGRendererInterface::Software);
    const QUrl url(QStringLiteral("qrc:/CustomWindowTitleBar/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

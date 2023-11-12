#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QUrl>

class AudioInfo : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int index READ getIndex WRITE setIndex NOTIFY indexChanged REQUIRED)
    Q_PROPERTY(QString title READ getTitle WRITE setTitle NOTIFY  titleChanged)
    Q_PROPERTY(QString author READ getAuthor WRITE setAuthor  NOTIFY authorChanged)
    Q_PROPERTY(QUrl imagePath READ getImagePath WRITE setImagePath NOTIFY imagePathChanged)
    Q_PROPERTY(QUrl songPath READ getSongPath WRITE setSongPath NOTIFY songPathChanged)


public:
    explicit AudioInfo(QObject *parent = nullptr);

    int getIndex() const;
    void setIndex(int newIndex);

    QString getTitle() const;
    void setTitle(const QString &newTitle);

    QString getAuthor() const;
    void setAuthor(const QString &newAuthor);

    QUrl getImagePath() const;
    void setImagePath(const QUrl &newImagePath);

    QUrl getSongPath() const;
    void setSongPath(const QUrl &newSongPath);

signals:

    void indexChanged();
    void titleChanged();
    void authorChanged();
    void imagePathChanged();
    void songPathChanged();

private:
    int m_index;
    QString m_title;
    QString m_author;
    QUrl m_imagePath;
    QUrl m_songPath;
};


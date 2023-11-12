#include "AudioInfo.h"

AudioInfo::AudioInfo(QObject *parent)
    : QObject{parent}
{

}

int AudioInfo::getIndex() const
{
    return m_index;
}

void AudioInfo::setIndex(int newIndex)
{
    if (m_index == newIndex)
        return;
    m_index = newIndex;
    emit indexChanged();
}

QString AudioInfo::getTitle() const
{
    return m_title;
}

void AudioInfo::setTitle(const QString &newTitle)
{
    if (m_title == newTitle)
        return;
    m_title = newTitle;
    emit titleChanged();
}

QString AudioInfo::getAuthor() const
{
    return m_author;
}

void AudioInfo::setAuthor(const QString &newAuthor)
{
    if (m_author == newAuthor)
        return;
    m_author = newAuthor;
    emit authorChanged();
}

QUrl AudioInfo::getImagePath() const
{
    return m_imagePath;
}

void AudioInfo::setImagePath(const QUrl &newImagePath)
{
    if (m_imagePath == newImagePath)
        return;
    m_imagePath = newImagePath;
    emit imagePathChanged();
}

QUrl AudioInfo::getSongPath() const
{
    return m_songPath;
}

void AudioInfo::setSongPath(const QUrl &newSongPath)
{
    if (m_songPath == newSongPath)
        return;
    m_songPath = newSongPath;
    emit songPathChanged();
}

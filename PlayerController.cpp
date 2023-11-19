#include "playercontroller.h"
#include "AudioInfo.h"
#include <QAudioOutput>

PlayerController::PlayerController(QObject *parent)
    : QAbstractListModel {parent}
{
    m_player.setAudioOutput(new QAudioOutput(&m_player));
    onAddAudio("Let me put my love into you", "ACDC", QUrl("qrc:/Qml9_player/assets/music/let_me_put_my_love_into_you.mp3"), QUrl("assets/images/cover_acdc.png"));
    onAddAudio("Don't boggart me", "Bong hits", QUrl("qrc:/Qml9_player/assets/music/dont_boggart_me.mp3"), QUrl("assets/images/cover_bong_hits.png"));
    onAddAudio("My girl", "Nirvana", QUrl("qrc:/Qml9_player/assets/music/my_girl.mp3"), QUrl("assets/images/cover_nirvana.png"));
    setAudioInfo(m_audioInfoList.first());
}

void PlayerController::setPlaying(bool newPlaying)
{
    if (m_playing == newPlaying)
        return;
    m_playing = newPlaying;
    emit isPlayingChanged();
}

bool PlayerController::isPlaying() const
{
    return m_playing;
}


void PlayerController::onNextClicked()
{
    auto currentSongIndex = m_audioInfoList.indexOf(m_currentAudioInfo);
    if ( currentSongIndex < 0)
    {
        qFatal() << "Current song not on the list";
    }
    auto newSongIndex = ((currentSongIndex + 1) % m_audioInfoList.size());
    setAudioInfo(m_audioInfoList.at(newSongIndex));

}

void PlayerController::onPreviousClicked()
{
    auto currentSongIndex = m_audioInfoList.indexOf(m_currentAudioInfo);
    if ( currentSongIndex < 0)
    {
        qFatal() << "Current song not on the list";
    }
    int newSongIndex = 0;
    if (currentSongIndex == 0)
    {
        newSongIndex = m_audioInfoList.size() - 1;
    }
    else
    {
        newSongIndex = currentSongIndex - 1;
    }
    setAudioInfo(m_audioInfoList.at(newSongIndex));
}

void PlayerController::onPlayPauseClicked()
{
    setPlaying(!m_playing);
    if(m_playing)
    {
        m_player.play();
    }
    else
    {
        m_player.pause();
    }
}

void PlayerController::onSourceChanged(const QUrl &newSongPath)
{

    m_player.stop();
    m_player.setSource(newSongPath);
    if(m_player.error() != QMediaPlayer::Error::NoError)
    {
        qCritical() << "Player error: " << m_player.errorString();
    }
    if(m_playing)
    {
        m_player.play();
    }
}

void PlayerController::onAddAudio(const QString &title, const QString &author, const QUrl &songPath, const QUrl &imagePath)
{
    beginInsertRows(QModelIndex(), m_audioInfoList.length(), m_audioInfoList.length());
    m_audioInfoList.push_back(new AudioInfo(title, author, songPath, imagePath, &m_player));
    endInsertRows();
}

void PlayerController::onSetAudioByIndex(int index)
{
    if(index >= 0 && index < m_audioInfoList.size())
    {
        setAudioInfo(m_audioInfoList.at(index));
    }
}


int PlayerController::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_audioInfoList.size();
}

QVariant PlayerController::data(const QModelIndex &index, int role) const
{
    if(checkIndex(index, CheckIndexOption::IndexIsValid))
    {
        auto* audioInfoElem = m_audioInfoList.at(index.row());
        switch (role) {
        case AudioTitleRole:
            return audioInfoElem->getTitle();
            break;
        case AudioAuthorRole:
            return audioInfoElem->getAuthor();
            break;
        case AudioImagePathRole:
            return audioInfoElem->getImagePath();
            break;
        case AudioSongPathRole:
            return audioInfoElem->getSongPath();
            break;
        default:
            qFatal() << "Role" << role << "not defined";
            break;
        }
    }
    return QVariant();
}


QHash<int, QByteArray> PlayerController::roleNames() const
{
    return QHash<int, QByteArray> { {AudioTitleRole, "audioTitle"},
                                  {AudioAuthorRole, "audioAuthor"},
                                  {AudioImagePathRole, "audioImagePath"},
                                  {AudioSongPathRole, "audioSongPath"}};
}

AudioInfo *PlayerController::audioInfo() const
{
    return m_currentAudioInfo;
}

void PlayerController::setAudioInfo(AudioInfo *newAudioInfo)
{
    if (m_currentAudioInfo == newAudioInfo)
        return;
    m_currentAudioInfo = newAudioInfo;
    emit audioInfoChanged();

    if(m_currentAudioInfo)
    {
        onSourceChanged(m_currentAudioInfo->getSongPath());
    }
    else
    {
        m_player.stop();
        m_player.setSource(QUrl());
        setPlaying(false);
    }
}

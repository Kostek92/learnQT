#include "playercontroller.h"
#include <QAudioOutput>

PlayerController::PlayerController(QObject *parent)
    : QObject{parent}
{
    m_player.setAudioOutput(new QAudioOutput(&m_player));
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

int PlayerController::getCurrentSongIndex() const
{
    return m_currentSongIndex;
}

void PlayerController::setCurrentSongIndex(int newCurrentSongIndex)
{
    if (m_currentSongIndex == newCurrentSongIndex)
        return;
    m_currentSongIndex = newCurrentSongIndex;
    emit currentSongIndexChanged();
}

int PlayerController::getSongsCount() const
{
    return m_songsCount;
}

void PlayerController::setSongsCount(int newSongsCount)
{
    if (m_songsCount == newSongsCount)
        return;
    m_songsCount = newSongsCount;
    emit songsCountChanged();
}

void PlayerController::onNextClicked()
{
    setCurrentSongIndex((m_currentSongIndex + 1) % m_songsCount);
}

void PlayerController::onPreviousClicked()
{
    if (m_currentSongIndex == 0)
    {
        setCurrentSongIndex(m_songsCount - 1);
    }
    else
    {
        setCurrentSongIndex(m_currentSongIndex - 1);
    }
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



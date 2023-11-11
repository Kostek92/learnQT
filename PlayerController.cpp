#include "playercontroller.h"

PlayerController::PlayerController(QObject *parent)
    : QObject{parent}
{

}

void PlayerController::setPlaying(bool newPlaying)
{
    if (_playing == newPlaying)
        return;
    _playing = newPlaying;
    emit isPlayingChanged();
}

bool PlayerController::isPlaying() const
{
    return _playing;
}

int PlayerController::getCurrentSongIndex() const
{
    return _currentSongIndex;
}

void PlayerController::setCurrentSongIndex(int newCurrentSongIndex)
{
    if (_currentSongIndex == newCurrentSongIndex)
        return;
    _currentSongIndex = newCurrentSongIndex;
    emit currentSongIndexChanged();
}

int PlayerController::getSongsCount() const
{
    return _songsCount;
}

void PlayerController::setSongsCount(int newSongsCount)
{
    if (_songsCount == newSongsCount)
        return;
    _songsCount = newSongsCount;
    emit songsCountChanged();
}

void PlayerController::onNextClicked()
{
    setCurrentSongIndex((_currentSongIndex + 1) % _songsCount);
}

void PlayerController::onPreviousClicked()
{
    if (_currentSongIndex == 0)
    {
        setCurrentSongIndex(_songsCount - 1);
    }
    else
    {
        setCurrentSongIndex(_currentSongIndex - 1);
    }
}

void PlayerController::onPlayPauseClicked()
{
    setPlaying(!_playing);
}



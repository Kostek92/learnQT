#ifndef PLAYERCONTROLLER_H
#define PLAYERCONTROLLER_H

#include <QObject>

class PlayerController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool playing READ isPlaying NOTIFY isPlayingChanged)
    Q_PROPERTY(int currentSongIndex READ getCurrentSongIndex NOTIFY currentSongIndexChanged)
    Q_PROPERTY(int songsCount READ getSongsCount NOTIFY songsCountChanged)

public:
    explicit PlayerController(QObject *parent = nullptr);
    bool isPlaying() const;
    int getCurrentSongIndex() const;
    int getSongsCount() const;

public slots:
    void onNextClicked();
    void onPreviousClicked();
    void onPlayPauseClicked();

signals:
    void isPlayingChanged();
    void currentSongIndexChanged();
    void songsCountChanged();

private:
    void setPlaying( bool playing);
    void setCurrentSongIndex(int newCurrentSongIndex);
    void setSongsCount(int newSongsCount);

    bool _playing = false;
    int _currentSongIndex = 0;
    int _songsCount = 3;

};

#endif // PLAYERCONTROLLER_H

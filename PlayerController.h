#ifndef PLAYERCONTROLLER_H
#define PLAYERCONTROLLER_H

#include <QAbstractListModel>
#include <QMediaPlayer>

class AudioInfo;
class PlayerController : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool playing READ isPlaying NOTIFY isPlayingChanged)
    Q_PROPERTY(AudioInfo* audioInfo READ audioInfo NOTIFY audioInfoChanged)

public:
    enum Roles
    {
        AudioTitleRole = Qt::UserRole + 1,
        AudioAuthorRole,
        AudioImagePathRole,
        AudioSongPathRole,
    };

    explicit PlayerController(QObject *parent = nullptr);
    bool isPlaying() const;
    AudioInfo *audioInfo() const;
    void setAudioInfo(AudioInfo *newAudioInfo);


    // QAbstractItemModel interface
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void onNextClicked();
    void onPreviousClicked();
    void onPlayPauseClicked();
    void onSourceChanged(const QUrl& newSongPath);
    void onAddAudio(const QString& title, const QString& author, const QUrl& songPath, const QUrl& imagePath);
    void onSetAudioByIndex(int index);
    void onRemoveAudioByIndex(int index);

signals:
    void isPlayingChanged();
    void audioInfoChanged();

private:
    void setPlaying( bool playing);
    bool isIndexValid(int index) const;
    int getCurrentSongIndex() const;

    bool m_playing = false;
    QMediaPlayer m_player;
    QList<AudioInfo*> m_audioInfoList;
    AudioInfo *m_currentAudioInfo = nullptr;
};

#endif // PLAYERCONTROLLER_H

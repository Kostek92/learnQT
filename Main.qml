import QtQuick
import QtQuick.Window
import com.company.PlayerController

Window {
    width: 640
    height: 640
    visible: true
    title: qsTr("Playa")

    Rectangle{
        id: topbar
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 60

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#5F8575" }
            GradientStop { position: 1.0; color: Qt.lighter("#5F8575") }
        }

        ImageButton
        {
            source: "assets/icons/menu_icon.png"
            anchors
            {
                right: topbar.right
                top: topbar.top
                bottom: topbar.bottom
                margins: 15
            }
            width: 40
            onButtonClicked:
            {
                playlist.isVisible = !playlist.isVisible
            }
        }
    }

    Rectangle{
        id: recordInfo
        anchors{
            top: topbar.bottom
            bottom: navigationBar.top
            left: parent.left
            right: parent.right
        }
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: Qt.lighter("#1e1e1e") }
            GradientStop { position: 0.5; color: "#1e1e1e"}
            GradientStop { position: 1.0; color: Qt.lighter("#1e1e1e") }
        }
        AudioInfoBox
        {
            anchors
            {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
        }
    }

    PlaylistPanel
    {
        id: playlist
        anchors.top: topbar.bottom
        x: playlist.isVisible ? parent.width - playlist.width : parent.width
    }

    Rectangle{
        id: navigationBar
        anchors{
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 100
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.lighter("#333333") }
            GradientStop { position: 1.0; color: "#333333" }
        }

        Row
        {
            id: buttonsRow
            anchors.centerIn: parent
            spacing: 20
            ImageButton
            {
                id: buttonPreviousSong
                width: 60
                height: 60
                buttonSource: "assets/icons/previous_icon.png"
                onButtonClicked:
                {
                    PlayerController.onPreviousClicked()
                }
            }
            ImageButton
            {
                id: buttonPlayPause
                width: 60
                height: 60
                buttonSource: PlayerController.playing ? "assets/icons/pause_icon.png" : "assets/icons/play_icon.png"

                onButtonClicked:
                {
                    PlayerController.onPlayPauseClicked()
                }
            }
            ImageButton
            {
                id: buttonNextSong
                width: 60
                height: 60
                buttonSource: "assets/icons/next_icon.png"
                onButtonClicked:
                {
                    PlayerController.onNextClicked()
                }
            }
        }
    }
}


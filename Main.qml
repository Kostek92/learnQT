import QtQuick
import QtQuick.Window
import com.company.PlayerController

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Playa")

    Rectangle{
        id: topbar
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 70

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#5F8575" }
            GradientStop { position: 1.0; color: Qt.lighter("#5F8575") }
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
            index: 0
            artistText: qsTr("ACDC")
            songText: qsTr("Back in black")

            coverImageSource: "assets/images/cover_acdc.png"
        }

        AudioInfoBox
        {
            anchors
            {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            index: 1
            artistText: qsTr("Compilation")
            songText: qsTr("Don't boggar me")

            coverImageSource: "assets/images/cover_bong_hits.png"
        }

        AudioInfoBox
        {
            anchors
            {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            index: 2
            artistText: qsTr("Nirvana")
            songText: qsTr("My girl")

            coverImageSource: "assets/images/cover_nirvana.png"
        }
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


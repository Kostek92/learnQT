import QtQuick
import QtQuick.Window
import QtQuick.Layouts

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
            GradientStop { position: 0.0; color: "#1e1e1e" }
            GradientStop { position: 0.5; color: Qt.lighter("#1e1e1e")}
            GradientStop { position: 1.0; color: "#1e1e1e" }
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
            artistText: qsTr("Wolfgang amadeus mozart")
            songText: qsTr("Eine kleine nachtmusik")

            coverImageSource: "red"
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
            artistText: qsTr("Compilaion")
            songText: qsTr("Bong hits")

            coverImageSource: "green"
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

            coverImageSource: "plum"
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
            spacing: 10
            TextButton
            {
                id: buttonPreviousSong
                width: 60
                height: 50
                buttonText: "<"
                onButtonClicked:
                {
                    playerController.onPreviousClicked()
                }
            }
            TextButton
            {
                id: buttonPlayPause
                width: 100
                height: 50
                buttonText: playerController.isPlaying ? "Pause" : "Play"

                onButtonClicked:
                {
                    playerController.onPlayClicked()
                }
            }
            TextButton
            {
                id: buttonNextSong
                width: 60
                height: 50
                buttonText: ">"
                onButtonClicked:
                {
                    playerController.onNextClicked()
                }
            }
        }
    }
    QtObject
    {
        id: playerController
        readonly property int songCount: 3
        property int currentSongIndex: 0
        property bool isPlaying: false

        function onNextClicked()
        {
            currentSongIndex = (currentSongIndex + 1) % songCount
        }
        function onPreviousClicked()
        {
            currentSongIndex = currentSongIndex == 0 ? songCount - 1 : currentSongIndex - 1
        }
        function onPlayClicked()
        {
            isPlaying = !isPlaying
        }
    }

}

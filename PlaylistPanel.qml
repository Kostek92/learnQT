import QtQuick
import com.company.PlayerController

Rectangle {
    property bool isVisible: false

    id: panel
    visible: true
    width: 300
    height: 400

    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.lighter("#333333") }
        GradientStop { position: 1.0; color: "#333333" }
    }
    Text {
        id: playlistTitle
        text: qsTr("Playlist")
        color: "white"
        font.pixelSize: 25
        font.bold: true
        anchors
        {
            left: parent.left
            top: parent.top
            margins:10
        }
    }

    Behavior on x {
        PropertyAnimation {
            easing.type: Easing.InQuad
            duration: 200
        }
    }

    ListView {
        id: playlistListview

        spacing:10
        anchors
        {
            top: playlistTitle.bottom
            bottom: addSong.top
            left: parent.left
            right: parent.right
            margins: 10
        }

        model: PlayerController
        delegate:
        Rectangle {

            required property string audioTitle
            required property string audioAuthor
            required property string audioSongPath
            required property string audioImagePath
            required property int index

            id: songsDelegate
            anchors
            {
                left: parent.left
                right:parent.right
            }

            height: 50
            color: "#1e1e1e"
            Column
            {
                id: audioTexts
                spacing: 5
                anchors
                {
                    left: parent.left
                    right: binIcon.left
                    top: parent.top
                    topMargin: 3
                    leftMargin: 5
                }
                Text {
                    id: title
                    text: songsDelegate.audioTitle
                    wrapMode: Text.WordWrap
                    font.pixelSize: 16
                    font.bold: true

                    color: "white"
                }

                Text {
                    id: author
                    text: songsDelegate.audioAuthor
                    font.pixelSize: 12
                    color: "lightgray"
                    wrapMode: Text.WordWrap
                }
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked:{
                    PlayerController.onSetAudioByIndex(index)
                }
            }

            ImageButton {
                id: binIcon
                source: "assets/icons/trash_icon.png"
                width:24
                anchors
                {
                    top:parent.top
                    bottom:parent.bottom
                    right: parent.right
                    margins: 5
                }
            }
        }
    }


    ImageButton
    {
        id: addSong

        anchors
        {
            left: parent.left
            bottom: parent.bottom
            margins:20
        }
        width: 32
        height: 32

        source: "assets/icons/add_icon.png"
    }

}

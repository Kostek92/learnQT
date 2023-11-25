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

    Connections {
        target: PlayerController
        function onAudioInfoIndexChanged(index) {
            playlistListview.currentIndex = index
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
        clip:true
        focus:true

        model: PlayerController

        delegate:
        Rectangle {
            id: songsDelegate
            
            required property string audioTitle
            required property string audioAuthor
            required property string audioSongPath
            required property string audioImagePath
            required property int index

            width: playlistListview.width
            height: 50
            color: ListView.isCurrentItem ? Qt.darker("#5F8575") : "1e1e1e"

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
                    width: audioTexts.width
                    elide: Text.ElideRight
                    minimumPixelSize: 12
                    font.pixelSize: 16
                    font.bold: true
                    color: "white"
                    text: songsDelegate.audioTitle
                }

                Text {
                    id: author
                    width: audioTexts.width
                    elide: Text.ElideRight
                    minimumPixelSize: 8
                    font.pixelSize: 12
                    color: "lightgray"
                    text: songsDelegate.audioAuthor
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
                anchors
                {
                    top:parent.top
                    bottom:parent.bottom
                    right: parent.right
                    margins: 5
                }
                onButtonClicked: {
                    PlayerController.onRemoveAudioByIndex(index);
                }
            }
        }

        Keys.onPressed: (event)=>{
            if(event.key === Qt.Key_Enter || event.key === Qt.Key_Space)
                PlayerController.onPlayPauseClicked()
        }
        Keys.onDownPressed:{
            if(isVisible){
                PlayerController.onNextClicked()
            }
        }
        Keys.onUpPressed:{
            if(isVisible){
                PlayerController.onPreviousClicked()
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
        onButtonClicked:
        {
            PlayerController.onAddAudio("Spalic gniew", "O.S.T.R", "qrc:/Qml9_player/assets/music/spalic_gniew.mp3", "assets/images/cover_ostr.jpg");
        }
    }

}

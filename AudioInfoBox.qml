import QtQuick
import QtQuick.Layouts
import com.company.PlayerController
import Qml9_player

Item {
    id: root

    property AudioInfo audioInfo: PlayerController.audioInfo
    visible: PlayerController.currentSongIndex === audioInfo.index

    onVisibleChanged:
    {
        if(visible)
        {
            PlayerController.onSourceChanged(audioInfo.songPath)
        }
    }

    Image
    {
        id: cdCover

        anchors
        {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 20
        }
        width: 150
        height: 150
        source: audioInfo.imagePath
        mipmap: true
    }

    Text {
        id: artist
        text: audioInfo.author
        anchors
        {
            bottom: parent.verticalCenter           
            left: cdCover.right
            right: parent.right
            margins: 15
        }
        wrapMode: Text.WordWrap
        font
        {
            pixelSize: 24
            bold: true
        }
        color: "white"
    }

    Text {
        id: title
        text: audioInfo.title
        anchors
        {
            top: parent.verticalCenter
            left: artist.left
            right: parent.right
            topMargin: 15
        }
        font.pixelSize: 20
        color: "lightgray"

        wrapMode: Text.WordWrap
    }
}

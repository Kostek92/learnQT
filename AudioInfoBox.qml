import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property alias coverImageSource: cdCover.color
    property alias artistText : artist.text
    property alias songText : song.text
    property int index

    visible: playerController.currentSongIndex == index
    Rectangle
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
    }

    Text {
        id: artist
        anchors
        {
            bottom: parent.verticalCenter           
            left: cdCover.right
            right: parent.right
            margins: 20
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
        id: song
        anchors
        {
            top: parent.verticalCenter
            left: artist.left
            right: parent.right
            topMargin:20
        }
        font.pixelSize: 20
        color: "lightgray"

        wrapMode: Text.WordWrap
    }
}

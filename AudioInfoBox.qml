import QtQuick
import QtQuick.Layouts
import com.company.PlayerController

Item {
    id: root

    property alias coverImageSource: cdCover.source
    property alias artistText : artist.text
    property alias songText : song.text
    required property int index
    visible: PlayerController.currentSongIndex === index

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
        mipmap: true
    }

    Text {
        id: artist
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
        id: song
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

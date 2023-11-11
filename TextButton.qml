import QtQuick


Rectangle
{
    property color baseColor: "gray"
    property alias buttonText: name.text
    signal buttonClicked()

    id: button

    radius: 3
    color: getColor()
    Text {
        id: name

        text: qsTr(buttonText)
        font.pixelSize: 18
        anchors.centerIn: parent
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked:
        {
            buttonClicked()
        }
    }

    function getColor()
    {
        if (mouseArea.containsPress)
        {
            return Qt.darker(baseColor)
        }
        else if (mouseArea.containsMouse)
        {
            return Qt.lighter(baseColor)
        }
        else
        {
            return baseColor
        }
    }
}


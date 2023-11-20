import QtQuick


Image
{
    id: button

    property alias buttonSource: button.source
    signal buttonClicked()

    mipmap: true        //Help improve quality of .png
    fillMode: Image.PreserveAspectFit
    opacity: getOpacity()

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

    function getOpacity()
    {
        if (mouseArea.containsPress)
        {
            return 0.8
        }
        else
        {
            return 1
        }
    }
}


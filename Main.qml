import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    flags: Qt.Window | Qt.FramelessWindowHint
    property int previousX
    property int previousY
    minimumWidth: 640
    minimumHeight: 480

    Rectangle {
        id: titlebar
        width: parent.width
        height: 40
        color: "#202020"
        anchors.top: parent.top

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image{
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
                Layout.alignment: Qt.AlignVCenter
                width: 30
                height: 30
                source: "qrc:/image/titlelogo.png"
            }

            Text {
                Layout.alignment: Qt.AlignVCenter
                text: mainWindow.title
                color: "white"
                font.family: "Calibri"
                font.pointSize: 11
            }
        }

        MouseArea {
            anchors.fill: parent
            property bool isDragging: false

            onPressed: {
                isDragging = true
                previousX = mouseX
                previousY = mouseY
            }
            onPositionChanged: {
                if (isDragging) {
                    var dx = mouseX - previousX
                    var dy = mouseY - previousY

                    // Directly update the window position
                    mainWindow.x += dx;
                    mainWindow.y += dy;

                    // Update the previous mouse position
                    previousX = mouseX
                    previousY = mouseY
                }
            }
            onReleased: {
                isDragging = false
            }
        }


    }

    Rectangle {
        anchors.top: titlebar.bottom
        implicitHeight: parent.height - titlebar.height
        implicitWidth: parent.width
        color: "#333"
    }

    MouseArea {
        width: 5
        anchors {
            right: parent.right
            top: titlebar.bottom
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeHorCursor
        onPressed: {
            previousX = mouseX
        }
        onMouseXChanged: {
            var dx = mouseX - previousX
            if (mainWindow.width + dx > mainWindow.minimumWidth) {
                mainWindow.width += dx
            }
            previousX = mouseX  // Update previousX after resizing
        }
    }

    MouseArea {
        width: 5
        anchors {
            left: parent.left
            top: titlebar.bottom
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeHorCursor
        onPressed: {
            previousX = mouseX
        }
        onMouseXChanged: {
            var dx = mouseX - previousX
            if (mainWindow.width - dx > mainWindow.minimumWidth) {
                mainWindow.setX(mainWindow.x + dx)
                mainWindow.setWidth(mainWindow.width - dx)
            }
            previousX = mouseX  // Update previousX after resizing
        }
    }

    MouseArea {
        height: 5
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeVerCursor
        onPressed: {
            previousY = mouseY
        }
        onMouseYChanged: {
            var dy = mouseY - previousY
            if (mainWindow.height + dy > mainWindow.minimumHeight) {
                mainWindow.setHeight(mainWindow.height + dy)
            }
            previousY = mouseY  // Update previousY after resizing
        }
    }

    MouseArea {
        height: 5
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        cursorShape: Qt.SizeVerCursor
        onPressed: {
            previousY = mouseY
        }
        onMouseYChanged: {
            var dy = mouseY - previousY
            var newY = mainWindow.y + dy
            var newHeight = mainWindow.height - dy
            if (newHeight > mainWindow.minimumHeight) {
                mainWindow.setY(newY)
                mainWindow.setHeight(newHeight)
            }
            previousY = mouseY  // Update previousY after resizing
        }
    }
}

import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

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

        Text {
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: 8
            text: mainWindow.title
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }
            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.x += dx
            }
            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.y += dy
            }
        }
    }

    Rectangle {
        anchors.top: titlebar.bottom
        implicitHeight: parent.height - titlebar.height
        implicitWidth: parent.width
        color: "#333"
    }

    // Right edge
    MouseArea {
        width: 5
        anchors {
            right: parent.right
            top: titlebar.bottom
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeHorCursor
        onMouseXChanged: {
            var dx = mouseX - previousX
            if (mainWindow.width + dx > mainWindow.minimumWidth) {
                mainWindow.width += dx
            }
        }
    }

    // Left edge
    MouseArea {
        width: 5
        anchors {
            left: parent.left
            top: titlebar.bottom
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeHorCursor
        onMouseXChanged: {
            var dx = mouseX - previousX
            if (mainWindow.width - dx > mainWindow.minimumWidth) {
                mainWindow.setX(mainWindow.x + dx)
                mainWindow.setWidth(mainWindow.width - dx)
            }
        }
    }

    // Bottom edge
    MouseArea {
        height: 5
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeVerCursor
        onMouseYChanged: {
            var dy = mouseY - previousY
            if (mainWindow.height + dy > mainWindow.minimumHeight) {
                mainWindow.setHeight(mainWindow.height + dy)
            }
        }
    }

    // Top edge
    MouseArea {
        height: 5
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        cursorShape: Qt.SizeVerCursor
        onMouseYChanged: {
            var dy = mouseY - previousY
            var newY = mainWindow.y + dy
            var newHeight = mainWindow.height - dy
            if (newHeight > mainWindow.minimumHeight) {
                mainWindow.setY(newY)
                mainWindow.setHeight(newHeight)
            }
        }
    }
}

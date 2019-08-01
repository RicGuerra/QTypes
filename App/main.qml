import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    width: 360
    height: 520
    visible: true
    title: "QTypes"

    header: ToolBar {
        Material.foreground: "white"

            ToolButton {
                icon.source: stackView.depth > 1 ? "qrc:/App/icons/back.png" : "qrc:/App/icons/drawer.png"
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        listView.currentIndex = -1
                    } else {
                        drawer.open()
                    }
                }
            }

            Label {
                text: listView.currentItem ? listView.currentItem.text : ""
                font.pixelSize: 20
                elide: Label.ElideRight
                anchors.centerIn: parent
                Layout.fillWidth: true
            }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        interactive: stackView.depth === 1

        ListView {
            id: listView
            focus: true
            currentIndex: -1
            anchors.fill: parent
            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(model.source)
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title: qsTr("SearchModel");            source: "qrc:/Examples/SearchModel/Simple.qml" }
                ListElement { title: qsTr("SearchModel > Advanced"); source: "qrc:/Examples/SearchModel/Advanced.qml" }
                ListElement { title: qsTr("Accordion");              source: "qrc:/Examples/Accordion/Simple.qml" }
                ListElement { title: qsTr("Accordion > Advanced");   source: "qrc:/Examples/Accordion/Advanced.qml" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.margins: 10
        initialItem: Pane {
            Label {
                anchors.centerIn: parent
                bottomPadding: 40
                font.pixelSize: 40
                font.bold: true
                leftPadding: 1
                elide: Label.ElideRight
                color: Material.primary
                text: "QTypes"
            }
        }
    }
}
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick 2.12
import QtQuick.Controls.Material 2.12

Item {
    property alias backgroundColor: rectangle.color

    Rectangle {
        id: rectangle
        anchors.fill: parent

        color: "White"

        ColumnLayout {
            anchors.fill: parent
            margins: 5
            spacing: 5
            Row {
                Layout.preferredHeight: 25
            }

            UITextInputForm {
                name: "Scenario"
                value: "Default Adult Male"
                Layout.alignment: Qt.AlignHCenter
            }

            GridLayout {
                columns: 4
                rows: 2

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                UITextInputForm {
                    name: "Age:"
                    value: "22"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 25
                }
                UITextInputForm {
                    name: "Gender:"
                    value: "Male"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 25
                }
                UITextInputForm {
                    name: "Fat%:"
                    value: "22.5"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                }
                UITextInputForm {
                    name: "Temp:"
                    value: "36.2"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                }

                UITextInputForm {
                    name: "Height:"
                    value: "22"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                }
                UITextInputForm {
                    name: "Weight:"
                    value: "Male"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                }
                UITextInputForm {
                    name: "BSA%:"
                    value: "22.5"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                }
                UITextInputForm {
                    name: "BSA:"
                    value: "36.2"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 75
                }
            }

            GridLayout {
                margins: 5
                Layout.preferredWidth: parent.width
                Layout.fillWidth: true
                layoutDirection: GridLayout.LeftToRight
                columns: 2
                rows: 3
                UIScalarForm {
                    name: "HR"
                    value: "75"
                }
                UIScalarForm {
                    name: "SBP"
                    value: "110"
                }
                UIScalarForm {
                    name: "RR"
                    value: "12"
                }
                UIScalarForm {
                    name: "DBP"
                    value: "68"
                }
                UIScalarForm {
                    name: "SAT"
                    value: "99"
                }
                UIScalarForm {
                    name: "Conditon"
                    value: "Running"
                }
            }

            GridLayout {
                Layout.preferredWidth: parent.width
                Layout.fillWidth: true
                layoutDirection: GridLayout.LeftToRight
                columns: 5
                Rectangle {
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    color: 'blue'
                }
                Rectangle {
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    color: 'green'
                }
                Rectangle {
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    color: 'blue'
                }
                Rectangle {
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    color: 'green'
                }
                Rectangle {
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    color: 'blue'
                }
            }

            GridLayout {
                Layout.preferredWidth: parent.width
                Layout.fillWidth: true
                layoutDirection: GridLayout.LeftToRight
                columns: 2
                rows: 10
                TextArea {
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: 200
                    Layout.fillHeight: true
                    Layout.rowSpan: 4
                    Layout.column: 1
                    Layout.row: 1

                    color: 'blue'
                }

                TextArea {
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: 200
                    Layout.fillHeight: true
                    color: 'blue'
                    Layout.rowSpan: 5
                    Layout.column: 1
                    Layout.row: 5
                }
                Rectangle {
                    color: 'steelblue'
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 15
                    Layout.column: 2
                    Layout.row: 1
                }
                Rectangle {
                    color: 'steelblue'
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 15
                    Layout.column: 2
                    Layout.row: 2
                }
                Rectangle {
                    color: 'steelblue'
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 15
                    Layout.column: 2
                    Layout.row: 3
                }
                Rectangle {
                    color: 'steelblue'
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 15
                    Layout.column: 2
                    Layout.row: 4
                }
                Rectangle {
                    color: 'steelblue'
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 15
                    Layout.column: 2
                    Layout.row: 5
                }
                Rectangle {
                    color: 'steelblue'
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 15
                    Layout.column: 2
                    Layout.row: 6
                }
                Rectangle {
                    color: 'transparent'
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 15 * 5
                    Layout.column: 2
                    Layout.row: 7
                    Layout.rowSpan: 3
                }
            }

            Rectangle {
                color: 'steelblue'
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}




/*##^## Designer {
    D{i:0;autoSize:true;height:800;width:300}
}
 ##^##*/

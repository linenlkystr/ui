import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 2.12
import com.biogearsengine.ui.scenario 1.0

UIComboBoxForm {
    id: root
    property alias label :root.label
    property Scenario scenario



    FolderListModel {
        id: folderModel
        nameFilters: ["*.xml"]
        folder: "file:states"
        showDirs : false
        }

    comboBox.model: folderModel
    comboBox.textRole: 'fileName'
    comboBox.currentIndex: 0
    comboBox.delegate: ItemDelegate {
        width: comboBox.width
        contentItem: Text {
            id: comboBoxDelegateText
            text: model.fileName.toString().split('@')[0]
            font: comboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        height :  15 //TODO: Set this number to a minimum of the height we want and this floor
        highlighted: comboBox.highlightedIndex === index
    }
    comboBox.onAccepted:  {
        scenario.load_patient(comboBox.currentText);
    }
    comboBox.onActivated:  {
        scenario.load_patient(comboBox.currentText);
    }
    onScenarioChanged: {

    }
}








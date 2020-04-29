import QtQuick 2.12
import QtQuick.Window 2.12
import com.biogearsengine.ui.scenario 1.0


WizardDialogForm {
	id: root

	property var activeWizard;

	function launchPatient(mode){
		mainDialog.title = 'Patient Wizard'
		let patientComponent = Qt.createComponent("UIPatientWizard.qml");
		if ( patientComponent.status != Component.Ready){
		  if (patientComponent.status == Component.Error){
			  console.log("Error : " + patientComponent.errorString() );
			  return;
		  }
	    console.log("Error : Action dialog component not ready");
	  } else {
		  activeWizard = patientComponent.createObject(mainDialog.contentItem, {'width' : mainDialog.contentItem.width, 'height' : mainDialog.contentItem.height, 'name' : 'activeWizard'});
			root.setHelpText("-Patient name and gender are required fields.  All other fields are optional and will be set to defaults in BioGears if not assigned. 
                \n\n -Baseline inputs will be used as targets for the engine but final values may change during the stabilization process.")
			if (mode === "Edit"){
				let patient = scenario.edit_patient()
				if (Object.keys(patient).length == 0){
					//We get an empty patient object if the user closed file explorer without selecting a patient
					activeWizard.destroy()
					return;
				} else {
					activeWizard.mergePatientData(patient)
					activeWizard.editMode = true
				}
			}
			//Connect standard dialog buttons to patient functions
			mainDialog.saveButton.onClicked.connect(activeWizard.checkConfiguration)
			mainDialog.onReset.connect(activeWizard.resetConfiguration)
			//Notifications from patient editor to main dialog
			activeWizard.onValidConfiguration.connect(root.saveData)
			activeWizard.onInvalidConfiguration.connect(root.showConfigWarning)
			activeWizard.onNameChanged.connect(root.showNameWarning)
			mainDialog.open()
		}
	}
	function launchEnvironment(mode){
		console.log(mode)
	}
	function launchSubstance(mode) {
		console.log(mode)
	}
	function launchCompound(mode) {
		console.log(mode)
	}
	function launchNutrition(mode) {
		mainDialog.title = 'Nutrition Wizard'
		let nutritionComponent = Qt.createComponent("UINutritionWizard.qml");
		if ( nutritionComponent.status != Component.Ready){
		  if (nutritionComponent.status == Component.Error){
			  console.log("Error : " + nutritionComponent.errorString() );
			  return;
		  }
	    console.log("Error : Action dialog component not ready");
	  } else {
		  activeWizard = nutritionComponent.createObject(mainDialog.contentItem, {'width' : mainDialog.contentItem.width, 'height' : mainDialog.contentItem.height, 'name' : 'activeWizard'});
			root.setHelpText("-Nutrition name is required field.  All other fields are optional and will be set to 0 if not defined.")
			if (mode === "Edit"){
				let nutrition = scenario.edit_nutrition()
				if (Object.keys(nutrition).length == 0){
					//We get an empty nutrition object if the user closed file explorer without selecting a nutrition
					activeWizard.destroy()
					return;
				} else {
					activeWizard.mergeNutritionData(nutrition)
					activeWizard.editMode = true
				}
			}
			//Connect standard dialog buttons to nutrition functions
			mainDialog.saveButton.onClicked.connect(activeWizard.checkConfiguration)
			mainDialog.onReset.connect(activeWizard.resetConfiguration)
			//Notify dialog that nutrition is ready
			activeWizard.onValidConfiguration.connect(root.saveData)
			activeWizard.onInvalidConfiguration.connect(root.showConfigWarning)
			activeWizard.onNameChanged.connect(root.showNameWarning)
			mainDialog.open()
		}
	}
	function launchECG(mode){
		console.log(mode)
	}

	function saveData(type, dataMap){
		switch (type) {
			case 'Patient' : 
				scenario.create_patient(dataMap)
				break;
			case 'Nutrition':
				scenario.create_nutrition(dataMap)
				break;
			}
		mainDialog.accept()
	}

	function setHelpText(helpText){
		helpDialog.helpText = helpText
	}
	function showNameWarning(){
		nameWarningDialog.open()
	}
	function showConfigWarning(errorStr){
		invalidConfigDialog.warningText = errorStr
		invalidConfigDialog.open()
	}

	function clearWizard(){
		mainDialog.saveButton.onClicked.disconnect(activeWizard.checkConfiguration)
		mainDialog.onReset.disconnect(activeWizard.resetConfiguration)
		activeWizard.onValidConfiguration.disconnect(root.saveData)
		activeWizard.onInvalidConfiguration.disconnect(root.showConfigWarning)
		activeWizard.onNameChanged.disconnect(root.showNameWarning)
		activeWizard.destroy()
		activeWizard = null
	}

	mainDialog.onAccepted : {
		root.clearWizard()
	}
	mainDialog.onRejected : {
		root.clearWizard()
	}
	mainDialog.onHelpRequested : {
		helpDialog.open()
	}
}

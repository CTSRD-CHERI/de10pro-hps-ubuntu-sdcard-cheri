pipeline {
	agent { label 'imagebuilder' }
	stages {
		stage('Pull artifacts') {
			steps {
				copyArtifacts filter: '**', fingerprintArtifacts: true, projectName: 'thunderclap-fpga-arria10/master'
			}
		}

		stage ('Build') {
			steps {
				sh './build-thunderclap-sdcard.sh'
			}
		}
	}
}

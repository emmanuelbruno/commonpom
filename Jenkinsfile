#!groovy

node() {
    try {
        
        stage('Checkout') {
            checkout scm
        }

        def gitRemote = sh(returnStdout: true, script: 'git remote get-url origin|cut -c9-').trim()
        def commitId = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()

        docker.image('brunoe/maven:8-3.3.9')
                .inside('-v /home/jenkins/.m2:/home/user/.m2' +
                '-v /home/jenkins/.sonar:/home/user/.sonar') {

            stage('Build') {
                sh "mvn --settings /home/user/.m2/settings.xml " +
                        "-Duser.home=/home/user " +
                        "-B " +
                        "-P artifactory " +
                        "-Dmaven.test.failure.ignore " +
                        "clean org.jacoco:jacoco-maven-plugin:prepare-agent package"
            }

            stage('Quality') {
                sh "mvn --settings /home/user/.m2/settings.xml " +
                        "-Duser.home=/home/user " +
                        "-B " +
                        "-P artifactory " +
                        "verify"
                sh "mvn --settings /home/user/.m2/settings.xml " +
                        "-Duser.home=/home/user " +
                        "-B " +
                        "-P " +
                        "artifactory,sonar " +
                        "sonar:sonar"
            }
        }

        stage('Archive') {
            junit '**/target/surefire-reports/TEST-*.xml'
        }

        stage('Publish') {
            sh "mvn --settings /home/user/.m2/settings.xml " +
                    "-Duser.home=/home/user " +
                    "-B " +
                    "-Dmaven.test.failure.ignore  " +
                    "-P artifactory " +
                    "deploy"
        }
    } catch (e) {
        throw e
    }
}
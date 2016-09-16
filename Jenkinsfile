#!groovy

node() {
    def slack_channel = "ci"

    try {

        stage('Checkout') {
            checkout scm
        }

        def commitId = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()

        docker.image('brunoe/maven:8-3.3.9')
                .inside('-v /home/jenkins/.m2:/home/user/.m2' +
                ' -v /home/jenkins/.sonar:/home/user/.sonar') {

            slackSend channel: slack_channel,
                    color: "good",
                    message: "[<${env.BUILD_URL}|${env.JOB_NAME}>] " +
                            "Building ${env.BRANCH_NAME}-${commitId}-${env.BUILD_NUMBER}"
            stage('Build') {
                sh "mvn --settings /home/user/.m2/settings.xml " +
                        "-Duser.home=/home/user " +
                        "-B " +
                        "-Dmaven.test.failure.ignore " +
                        "-P artifactory " +
                        "clean org.jacoco:jacoco-maven-plugin:prepare-agent package"
            }

            stage('Quality') {
                sh "mvn --settings /home/user/.m2/settings.xml " +
                        "-Duser.home=/home/user " +
                        "-P artifactory " +
                        "-B " +
                        "verify"
                sh "mvn --settings /home/user/.m2/settings.xml " +
                        "-Duser.home=/home/user " +
                        "-B " +
                        "-P sonar,artifactory " +
                        "sonar:sonar"
            }

            stage('Publish') {
                slackSend channel: slack_channel,
                        color: "good",
                        message: "[<${env.BUILD_URL}|${env.JOB_NAME}>] " +
                                "Building ${env.BRANCH_NAME}-${commitId}-${env.BUILD_NUMBER}"
                sh "mvn --settings /home/user/.m2/settings.xml " +
                        "-Duser.home=/home/user " +
                        "-B " +
                        "-Dmaven.test.failure.ignore  " +
                        "-P artifactory " +
                        "deploy"
            }
        }
    } catch (e) {
        throw e
    }
}
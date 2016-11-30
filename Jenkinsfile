#!groovy

@Library('github.com/emmanuelbruno/brunoe-pipeline-library@master') _

node() {
    try {
        jenkinsFileLSISUtils.slackChannel = "ci"
        jenkinsFileLSISUtils.mavenDockerImage = 'hub-docker.lsis.univ-tln.fr:443/brunoe/maven:3-3.9-SNAPSHOT'
        withCredentials([[$class          : 'UsernamePasswordMultiBinding',
                          credentialsId   : 'login.utln',
                          usernameVariable: 'UTLN_USERNAME',
                          passwordVariable: 'UTLN_PASSWORD']]) {
            jenkinsFileLSISUtils.UTLN_USERNAME = env.UTLN_USERNAME
            jenkinsFileLSISUtils.UTLN_PASSWORD = env.UTLN_PASSWORD
        }

        //checkout and set version with buildnumber
        jenkinsFileLSISUtils.init()

        jenkinsFileLSISUtils.mvnPackage()
        jenkinsFileLSISUtils.mvnDeploy("-P nexus-dev")
        jenkinsFileLSISUtils.mvnQuality()
        jenkinsFileLSISUtils.mvnDeploy("-P nexus-stage")
        jenkinsFileLSISUtils.mvnDeploy("-P nexus-prod")

        //jenkinsFileLSISUtils.gitTag()
    } catch (error) {
        slackSend channel: jenkinsFileLSISUtils.slackChannel,
                color: "danger",
                message: "Build Error. <${env.BUILD_URL}|${env.JOB_NAME} ${env.BUILD_NUMBER}>) : ${error}"
        throw error
    } finally {
    }

}
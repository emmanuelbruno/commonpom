#!groovy

@Library('github.com/emmanuelbruno/brunoe-pipeline-library@master') _

node() {
    try {
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
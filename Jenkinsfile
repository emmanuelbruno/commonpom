#!groovy

@Library('github.com/emmanuelbruno/brunoe-pipeline-library@master') _

node() {
    try {
        //In jenkins add settings.xml, settings-security.xml, login.utln (utln password)
        //This file should be protected (signed ?)

        jenkinsFileLSISUtils.slackChannel = "ci"
        jenkinsFileLSISUtils.mavenDockerImage = 'hub-docker.lsis.univ-tln.fr:443/brunoe/maven:3-3.9-SNAPSHOT'

        //checkout and set version with buildnumber
        jenkinsFileLSISUtils.init()

        jenkinsFileLSISUtils.mvnPackage()
        jenkinsFileLSISUtils.mvnDeploy("-P stage-devel")
        jenkinsFileLSISUtils.mvnQuality()
        jenkinsFileLSISUtils.mvnDeploy("-P stage-staging")
        jenkinsFileLSISUtils.mvnDeploy("-P stage-production")

        //jenkinsFileLSISUtils.gitTag()
    } catch (error) {
        slackSend channel: jenkinsFileLSISUtils.slackChannel,
                color: "danger",
                message: "Build Error. <${env.BUILD_URL}|${env.JOB_NAME} ${env.BUILD_NUMBER}>) : ${error}"
        throw error
    } finally {
    }

}
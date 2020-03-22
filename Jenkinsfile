pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/elinarnten/fooproject.git'
            }
        }
    
stage('Build') {
                    steps {
                        sh "mvn compile"
                    }
                }
                stage('Test') {
                    steps {
                        sh "mvn test"
                    }
                    post {
                        always {
                            junit '**/*.xml'
                        }
                    }
                }
	stage('newman') {
            steps {
                sh 'newman run RestfulBooker.postman_collection.json --environment RestfulBooker.postman_environment.json --reporters junit'
            }
            post {
                always {
                        junit '**/*xml'
                    }
                }
        }
        
    stage('Robot Framework System tests with Selenium') {
              steps {
                  sh 'robot -d results --variable BROWSER:headlesschrome ./Tests/infotiv.robot'
              }
              post {
                  always {
                      script {
                            step(
                                  [
                                    $class              : 'RobotPublisher',
                                    outputPath          : 'results',
                                    outputFileName      : '**/output.xml',
                                    reportFileName      : '**/report.html',
                                    logFileName         : '**/log.html',
                                    disableArchiveOutput: false,
                                    passThreshold       : 50,
                                    unstableThreshold   : 40,
                                    otherFiles          : "**/*.png,**/*.jpg",
                                  ]
                            )
                      }
                  }
              }
          }
      }
    post {
                 always {
                    junit '**/TEST*.xml'
                    emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
                    body: '!', recipientProviders: [culprits()], subject:
                    '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'
                 }
          }
    }
  
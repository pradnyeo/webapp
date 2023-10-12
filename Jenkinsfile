pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }
    environment {
      DOCKER_TAG = getVersion()
    }

    stages {
        stage('git-checkout') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/pradnyeo/webapp.git'

            }
        }
        stage('build') {
            steps {
                sh 'mvn install'
            }
        }
        stage ('NexusUploader') {
            steps {
 
                nexusArtifactUploader 
		    artifacts: [[artifactId: 'WebApp', 
				 classifier: '', 
				 file: '/var/lib/jenkins/workspace/first-project/target/WebApp.war', 
				 type: 'war']], 
			credentialsId: 'Nexus', 
			    groupId: 'lu.amazon.aws.demo', 
			    nexusUrl: '15.207.117.153:8081/', 
			    nexusVersion: 'nexus3', 
			    protocol: 'http', 
			    repository: 'webapp-artifacts', 
			    version: '1.0-SNAPSHOT'		
            }          
        }
        
        stage ('DeployWarFileToApache') {
            steps {
                deploy adapters: 
                [tomcat9(credentialsId: '6635eb1a-9c54-4f63-a97e-5b9bb2043d5d', path: '', url: 'http://13.235.18.52:8084/')], 
                contextPath: null, war: '**/*.war'
            }
        }
        stage ('Slack-notification') {
            steps {
                slackSend channel: '#devops-practice', 
                color: 'Good', message: 'Build & Deploy Successfully', 
                teamDomain: 'devops-wud2490', 
                tokenCredentialId: 'Slack-notif'
            }
        }
        
        stage ('Build Image') {
            steps {
                sh "docker build . -t pradnyeo/webapp:${DOCKER_TAG} "
            }
        }
        
        //docker push to registry
        stage ('Push Image') {
            steps {
                withCredentials([string(credentialsId: 'DockerHubPwd', variable: 'DockerHub')]) {
                   sh "docker login -u pradnyeo -p ${DockerHub}"
                }
                sh "docker push pradnyeo/webapp:${DOCKER_TAG}"
            }
        }
        
        //deploy container on Dev-server
        stage ('Deploy Container') {
            steps {
                ansiblePlaybook credentialsId: 'Dev-Server', 
                disableHostKeyChecking: true, 
                extras: "-e DOCKER_TAG=${DOCKER_TAG}", 
                installation: 'ansible', 
                inventory: 'dev.inv', 
                playbook: 'deploy.yaml'
            }
        }
       
        // get notification after dev env deployment

        stage('Dev env notification') {
		steps {
			 slackSend channel: '#devops-practice', 
                	color: 'Good', message: 'Deploy Successfully on Dev Env', 
                	teamDomain: 'devops-wud2490', 
                	tokenCredentialId: 'Slack-notif'        
		}
        }        
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}






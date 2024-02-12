pipeline {
    agent any
        environment {
                PROJECT_ID = 'usecase1-413317'
                CLUSTER_NAME = 'my-gke-cluster'
                LOCATION = 'us-west1'
                CREDENTIALS_ID = 'gke'
        }

    stages {
         stage('Terraform Init') {
            steps {
                script {
                    sh "terraform init"
                }
            }
        }
       
       

         stage('Terraform Apply') {
            steps {
                script {
                    sh "terraform refresh "
                    sh "terraform destroy -auto-approve"
                    sh "terraform apply -auto-approve"
                }
            }
        }
            
            stage('Building Docker Image') {
                    steps {
                            script {
                                    sh "docker build -t divija231/flask:${env.BUILD_ID} ."
                            }
                    }
            }
        
            stage("Pushing Docker Image") {
                    steps {
                            script {
                                    echo "Push Docker Image"
                                    withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                                        sh "docker login -u divija231 -p ${dockerhub}"
                                        sh "docker push divija231/flask:${env.BUILD_ID}"
                                    }
                            }
                    }
            }

            stage('Deploying to K8s') {
                    steps{
                                sh "sed -i 's/tagversion/${env.BUILD_ID}/g' deployment.yaml" 
                                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
                            echo "Deployment successfully finished ..."
                    }
             }
       }
}

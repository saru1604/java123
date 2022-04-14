pipeline {
agent any
environment {
AWS_ACCOUNT_ID=”149714379540” 
AWS_DEFAULT_REGION=”us-east-1”
IMAGE_REPO_NAME=”myimage”
IMAGE_TAG=”latest”
REPOSITORY_URI = “public.ecr.aws/d8h4x0g0/myimage”
}

stages {

stage(‘Logging into AWS ECR’) {
steps {
script {
sh “aws ecr get-login-password — region ${AWS_DEFAULT_REGION} | docker login — username AWS — password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com”
}

}
}

stage(‘Cloning Git’) {
steps {
checkout([$class: ‘GitSCM’, branches: [[name: ‘*/main’]],  userRemoteConfigs: [[credentialsId: ‘’, url: ‘https://github.com/saru1604/java123.git’]]])
}
}

// Building Docker images
stage(‘Building image’) {
steps{
script {
dockerImage = docker.build “${IMAGE_REPO_NAME}:${IMAGE_TAG}"
}
}
}

// Uploading Docker images into AWS ECR
stage(‘Pushing to ECR’) {
steps{
script {
sh “docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG”
sh “docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}”
}
}
}
}
}

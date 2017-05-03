node('testslave') {
  checkout scm
  env.PATH = "${tool 'Maven3'}/bin:${env.PATH}"
  stage('Package') {
    sh 'mvn clean package -DskipTests'
  }

  stage ('Docker Build') {
    // prepare docker build context
    sh "cp target/hello-world.war ./tmp-docker-build-context"

    // Build and push image with Jenkins' docker-plugin
    withDockerServer([uri: "tcp://192.168.40.188:2376"]) {
        // we give the image the same version as the .war package
        def image = docker.build("williamcrowell/helloworld:1.0", "--build-arg PACKAGE_VERSION=1.0 ./tmp-docker-build-context")
        image.run()
    }
  }
}

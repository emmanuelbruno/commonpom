A common pom with :
  - defaut maven repositories
  - generic scm, issueManagement, ciManagement
  - 3 stage profiles : stage-devel, stage-staging, stage-production (for maven and docker target repository).
  - maven site and github site generation
  - common version of main dependencies in dependencyManagement
  - common version and configuration of main plugins in pluginManagement
  - gitflow support
  - default maven exec and shaded jar 
  - docker image easy build
  - basic rules enforcing
  - basic jar signing

Update with :
  - mvn versions:display-dependency-updates
  - mvn versions:use-latest-versions
  - mvn versions:update-properties  

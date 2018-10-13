fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios prepare
```
fastlane ios prepare
```
Prepares the build by registering devices and checking installed dependencies
### ios register
```
fastlane ios register
```
Registers devices on the Apple Developer Portal.
### ios load_env
```
fastlane ios load_env
```

### ios certify
```
fastlane ios certify
```
Syncs codesigning certificates and provisioning profiles via Fastlane Match.
### ios certify_aps
```
fastlane ios certify_aps
```
Syncs certificates for Apple Push Services.
### ios build
```
fastlane ios build
```
Builds the app.
### ios test
```
fastlane ios test
```
Runs unit tests and outputs results in JUnit format.
### ios run_danger
```
fastlane ios run_danger
```

### ios deploy
```
fastlane ios deploy
```
Deploys the app.
### ios deploy_to_aws
```
fastlane ios deploy_to_aws
```

### ios deploy_to_hockeyapp
```
fastlane ios deploy_to_hockeyapp
```

### ios upload_symbols
```
fastlane ios upload_symbols
```

### ios prepare_pod_deploy
```
fastlane ios prepare_pod_deploy
```
Deploys the pod to the private spec repo.
### ios add_spec_repo
```
fastlane ios add_spec_repo
```
Adds the spec repo to the local cocoapods environment. (Local only)
### ios build_and_deploy
```
fastlane ios build_and_deploy
```
Then builds and deploys.
### ios commit
```
fastlane ios commit
```
Adds all files to a commit and gets a message from the terminal if none is provided, then pushes to remote. (Local only)
### ios pod_lint
```
fastlane ios pod_lint
```
Lints the pod library.

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

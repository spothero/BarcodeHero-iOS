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
Registers the devices (if possible), then checks and installs dependencies.
### ios register
```
fastlane ios register
```
Registers devices on the Apple Developer Portal.
### ios certify
```
fastlane ios certify
```
Syncs codesigning certificates and provisioning profiles via Fastlane Match. (App only)
### ios certify_aps
```
fastlane ios certify_aps
```
Syncs certificates for Apple Push Services. (App only)
### ios build
```
fastlane ios build
```
Builds the project.
### ios test
```
fastlane ios test
```
Runs unit tests and outputs results in JUnit format.
### ios run_danger
```
fastlane ios run_danger
```

### ios app_deploy
```
fastlane ios app_deploy
```
Deploys the app. (App only)
### ios app_deploy_to_aws
```
fastlane ios app_deploy_to_aws
```
Deploys the app to AWS. (App only)
### ios app_deploy_to_hockeyapp
```
fastlane ios app_deploy_to_hockeyapp
```
Deploys the app to HockeyApp. (App only)
### ios app_upload_symbols
```
fastlane ios app_upload_symbols
```
Uploads symbols to crashlytics and sentry. (App only)
### ios pod_bump
```
fastlane ios pod_bump
```
Bumps or sets the podspec and project version. (Pod only) (Local only)
### ios pod_deploy
```
fastlane ios pod_deploy
```

### ios pod_deploy_on_tag
```
fastlane ios pod_deploy_on_tag
```
Deploys the pod when a tag is pushed. (Pod only) (CI only)
### ios add_spec_repo
```
fastlane ios add_spec_repo
```
Adds the spec repo to the local cocoapods environment.
### ios commit
```
fastlane ios commit
```
Adds all files to a commit and gets a message from the terminal if none is provided, then pushes to remote. (Local only)
### ios test_and_lint
```
fastlane ios test_and_lint
```
Runs test and lints with danger.

If the project is a pod, it will also run the pod_lint lane.
### ios app_build_and_deploy
```
fastlane ios app_build_and_deploy
```
Builds then deploys. (App only)
### ios pod_lint
```
fastlane ios pod_lint
```
Lints the pod library. (Pod only)

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

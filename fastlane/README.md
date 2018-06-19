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
### ios check_dependencies
```
fastlane ios check_dependencies
```
Checks various dependencies and installs or updates them accordingly. (Ruby Gems, Fastlane, Cocoapods, Xcode)
### ios add_spec_repo
```
fastlane ios add_spec_repo
```
Adds the spec repo to the local cocoapods environment. (Local only)
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
### ios dorp
```
fastlane ios dorp
```

### ios test
```
fastlane ios test
```
Runs unit tests and outputs to JUnit.
### ios deploy
```
fastlane ios deploy
```
Deploys the pod to the private spec repo. (Local only)

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

## [0.5.0+1]
 * Adding fastlane for easier releases
Merge branch 'nfc_support' of https://github.com/CathalT/uni_links
Migrate to Flutter 2 and Dart 2 null safety system
Merge pull request #98 from avioli/avioli-patch-1
Update versions
Update pubspec.yaml
Update pubspec.yaml
Merge pull request #93 from hacker1024/web

Merge pull request #92 from hacker1024/modernized

Support the Web
uni_links: Example: Move the MaterialApp widget above MyApp
This allows features provided by the widget to be accessed from MyApp’s build method’s BuildContext.
uni_links: Android: Migrate to v2 embedding APIs
Migrate to the federated plugin architecture, null safety
- Migrate to a federated architecture
- Migrate to null safety
- Update example to work with the breaking API changes, and comply with effective Dart guidelines
Add missing fields to example pubspec
be pedantic
add pedantic dev-dep
exclude generated java files
add a button to force-quit the app
show the initial link in the example app
let both android studio and xcode alter their files
upgrade example's gradle
remove deprecated pubspec field - author
conform to latest plugin configuration for publishing
update changelog
sync version
update travis config
format the java files
use AOSP style instead of Google Style (4-space indentation)
Merge pull request #55 from markathomas/master
Fix UniLinks Plugin for Flutter 1.12.13
Merge branch 'master' into master
Merge pull request #42 from ened/ios-warnings
Reduce iOS compiler warnings
add format-dart to makefile
"format" the comments :)
add makefile to run the java and objective-c formatters
fix tests - init the binary messenger binding is running
fix used jdk and use latest version of the google-java-format
disable the apk and ipa app building jobs
add new example ignored files
add new ios ignored files
Add missing new intent listener registration
Fix UniLinks Plugin for Flutter 1.12.13
Update .travis.yml
Fix CI error
Bump version, update changelog.
Update iOS side in example project.
Add NS_ASSUME_NONNULL* macro to reduce compiler warnings.
iOS NFC NDEF support
Android NFC NDEF support
fix typo and add clarify that the Stream is also important
add some clarification about links starting your app
add some clarification what URIs can be used in the different configs
add attribution
Merge branch 'bbedward-master'
Fix example app
Update example
Update changelog and version
Update to androidX
remove the note for extra Objective-C code to support Universal Links; cleanup example.
Move uni_links to dep section from dev
Since that's the right place for it, although it doesn't matter for the example.
Merge pull request #13 from MisterJimson/master
Change "permissions" to "intent filters" in readme.
Update README.md

## [0.5.0] - 2020-12-28

**Breaking changes**  
Due to the migration to null safety, some APIs have changed. These changes mainly involve functions changing into getters, and types becoming explicitly nullable.  
The changes to the example package are a good example of how to upgrade to this version.
* Support null safety.
* Migrate to the federated plugin architecture, paving the way for Web support in the future.

## [0.4.0] - 2020-05-10

* Reduce iOS compiler warnings #42 (@ened)
* Fix UniLinks Plugin for Flutter 1.12.13 #55 (@markathomas)

## [0.2.1] - 2019-09-30

* Updated iOS example project project files.
* Added NS_NONNULL macro to iOS plugin header to reduce compiler warnings.

## [0.2.0] - 2019-03-10

**Breaking change**
  Migrate from the deprecated original Android Support Library to AndroidX. This shouldn't result in any functional changes, but it requires any Android apps using this plugin to [also migrate](https://developer.android.com/jetpack/androidx/migrate) if they're using the original support library.

* [Android] Update to AndroidX. (@bbedward)


## [0.1.4] - 2018-10-16

* [Android] Don't process links when launched in background. (@wkornewald)


## [0.1.3] - 2018-09-08

* No code changes.
* Added section in the README about Swift-enabled apps.
* Added section in the README about tooling for invoking links from the cli.


## [0.1.2] - 2018-07-30

* Fixed lost initialLink on iOS launch via Universal Link. (@wkornewald)


## [0.1.1] - 2018-05-31

* No code changes. Pushed to pub.dartlang.org with an untracked file that had to
  be manually removed.


## [0.1.0] - 2018-05-31

* Initial release.

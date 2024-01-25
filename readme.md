# Dotfiles

My dotfiles repo

## Fresh macOS setup

1. Update macOS to the latest version through the App Store
2. Install the full version of Xcode from the App Store
3. Run `xcode-select --install`
4. Migrate needed ssh-keys into `~/.ssh`
5. Clone repo into `~/.dotfiles`
6. Run the installer script `./install.sh`
7. Restart macOS

## Apple M1 or M2?

You might need Rosetta `softwareupdate --install-rosetta --agree-to-license`

## Work stuff
1. Keep Maven credentials in `~/.gradle/gradle.properties`

```shell
mavenUser=XXX
mavenPassword=XXX
usePoetry=true
```

2. Keep AWS credentials `~/.aws/credentials`

```
[default]
aws_access_key_id=XXX
aws_secret_access_key=XXX
```

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

3. Git hoooks

I use a global git hooks to prepend ticket name in the commits, based on the branch name. So if a branch is called `feat/dev/ABC-1234` the commit will be: `ABC-1234: My commit message`

Turn on

```bash
git config --global core.hooksPath /Users/urbansanden/.dotfiles/githooks
```

Turn off

```bash
git config --global --unset core.hooksPath
```

Verify if on or off

```bash
git config --global core.hooksPath

```

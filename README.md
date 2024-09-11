<p align="center">
  <img src = "https://cdn.wafflemaster.my.id/Frame%2013.png">
</p>

<p align="center"> 
  <img src="https://img.shields.io/badge/Platform-macOS-orange" alt="macOS badge" >
  <img src="https://img.shields.io/badge/SwiftUI-Generator-red" alt="Swift badge" tyle="float: right;" >
  <img src="https://img.shields.io/badge/Lisence-MIT-blue" alt="License Badge" tyle="float: right;">
  <img src="https://img.shields.io/badge/Version-Betav0.1.0-green" alt="Version Badge" style="float: right;">
</p>

# Xboiler

Xboiler is a SwiftUI-based framework designed to simplify the process of automatically generating boilerplate code from a YAML file. With xboiler, you can define folder and file structures in a YAML file, which will then be automatically generated into .swift files.

This framework eliminates repetitive tasks, where developers would normally have to manually copy files one by one when starting a new project. Xboiler is designed to streamline and accelerate this process, allowing developers to focus on core development without being bogged down by manual setup tasks.

## Installation

HomeBrew.

```bash
brew tap Waffle000/xboiler
brew install xboiler
```

## Example YAML

```yaml
outputFolder: MyAppProject
appName: MyApp
mainView: ContentView
bundleId: com.example.myapp
platform: iOS
deploymentTarget: 14.0
device: universal
views:
  - name: ContentView
    content: |
        ZStack {
            VStack {
                Text("Welcome to My App")
                Image("app_logo")
                Button(action: {
                    print("Button clicked")
                }) {
                    HStack {
                        Text("Click")
                        Text("Me")
                    }
                }
            }
        }
```

## Usage

Simple for usage
```bash
xboiler generate example.yaml
```

## Contributing

Pull requests and issues are always welcome. Please open any issues and PRs for bugs, features, or documentation.

## Attributions
This tool is powered by:

- [XcodeProj](https://github.com/tuist/XcodeProj)
- [PathKit](https://github.com/kylef/PathKit)
- [Yams](https://github.com/jpsim/Yams)

## License

Xboiler is licensed under the MIT license. See [LICENSE](LICENSE) for more info.

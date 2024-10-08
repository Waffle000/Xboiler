<p align="center">
  <img src = "https://cdn.wafflemaster.my.id/Frame%2013.png">
</p>

<p align="center"> 
  <img src="https://img.shields.io/badge/Platform-macOS-orange" alt="macOS badge" >
  <img src="https://img.shields.io/badge/SwiftUI-Generator-red" alt="Swift badge" tyle="float: right;" >
  <img src="https://img.shields.io/badge/Lisence-MIT-blue" alt="License Badge" tyle="float: right;">
  <img src="https://img.shields.io/badge/Version-Betav1.0.0-green" alt="Version Badge" style="float: right;">
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
outputFolder: MySwiftUIProject
appName: MyApp
mainView: HomeView
bundleId: com.myapp.example
platform: iOS
deploymentTarget: 16.0
device: universal
files:
  - name: ContentView
    type: view
    content: |
      Text("Welcome to Content View")

folders:
  - folderName: Views
    files:
      - name: HomeView
        type: view
        content: |
          Text("Welcome to Home View")

  - folderName: ViewModels
    files:
      - name: HomeViewModel
        type: class
        inherits:
          superclass: ObservableObject
        content: |
          @Published var title = "Home View"

  - folderName: Managers
    files:
      - name: DataManager
        type: class
        inherits:
          superclass: NSObject
          protocols:
            - DataManagerProtocol
        content: |
          func fetchData() {
              print("Fetching data...")
          }

  - folderName: Protocol
    files:
       - name: DataManagerProtocol
         type: protocol
         content: |
            func fetchData()


```

## Usage

Version
```bash
Xboiler --version
```

Simple for usage
```bash
Xboiler generate example.yaml
```

## Contributing

Pull requests and issues are always welcome. Please open any issues and PRs for bugs, features, or documentation.

## Attributions
This tool is powered by:

- [XcodegenKit](https://github.com/yonaskolb/XcodeGen)
- [PathKit](https://github.com/kylef/PathKit)
- [Yams](https://github.com/jpsim/Yams)

## License

Xboiler is licensed under the MIT license. See [LICENSE](LICENSE) for more info.

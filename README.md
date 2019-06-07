# menubarApp
An example menubar app which...
- is placed on menu bar
- can start and stop [echo server](https://en.wikipedia.org/wiki/Echo_Protocol)
- can open a window by selecting a menu item

## Runtime Environment
macOS 10.14 (Mojave) or later

## Development Environment
- macOS 10.14 (Mojave) or later
- Xcode 10.2.1 or later
- Swift 5
- [Cocoapods](https://guides.cocoapods.org/using/getting-started.html)

## Major Dependencies
- [SwiftSocket](https://github.com/swiftsocket/SwiftSocket)

## How to Build
On terminal, which can use Cocoapods :
```
cd ${repository_top_dir}
pod install
open menubarApp.xcworkspace
```

# stream-chat-swift

[![Language: Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

![StreamChatCore](https://img.shields.io/badge/Framework-StreamChatCore-blue)
![Cocoapods](https://img.shields.io/cocoapods/v/StreamChatCore.svg)
[![Core Documentation](https://github.com/GetStream/stream-chat-swift/blob/master/docs/core/badge.svg)](https://getstream.github.io/stream-chat-swift/core)

![StreamChat](https://img.shields.io/badge/Framework-StreamChat-blue)
![Cocoapods](https://img.shields.io/cocoapods/v/StreamChat.svg)
[![UI Documentation](https://github.com/GetStream/stream-chat-swift/blob/master/docs/ui/badge.svg)](https://getstream.github.io/stream-chat-swift/ui)

[stream-chat-swift](https://github.com/GetStream/stream-chat-swift) is the official iOS SDK for [Stream Chat](https://getstream.io/chat), a service for building chat applications.

You can sign up for a Stream account at [https://getstream.io/chat/get_started/](https://getstream.io/chat/get_started/).

## Requirements

- iOS 11
- Xcode 10.2
- Swift 5
- CocoaPods 1.7+

## Installation

Stream Chat SDK consists of two frameworks: `StreamChatCore` and `StreamChat`. 

- `StreamChatCore` — provide Stream Chat with models, presenters, notification manager and the client for requests and web socket events.
- `StreamChat` — depends on the first one and implements UI with customizable styles.

### CocoaPods

To integrate StreamChat into your Xcode project using CocoaPods, add this entry in your `Podfile`:
```
pod 'StreamChat'
```
Then run `pod install`.

If you want to use only `StreamChatCore`, you can add this entry in your `Podfile`:
```
pod 'StreamChatCore'
```

In any file you'd like to use Stream Chat in, don't forget to import the frameworks:
```
import StreamChatCore
```
and for UI components:
```
import StreamChat
```

### Carthage

To integrate Stream Chat into your Xcode project using Carthage, specify it in your `Cartfile`:
```
github "GetStream/stream-chat-swift"
```
Then run: `carthage update --platform iOS --new-resolver`. This will build frameworks: `StreamChatCore.framework` and `StreamChat.framework` into `<Path to your Project>/Carthage/Build/iOS/` from where you can add them to your project and link them with your app target. Follow with these steps:
- Open your Xcode project.
- Select the project in the Navigator.
- Select your app target.
- Open `General` panel.
- Click the `+` button in the `Linked Franeworks and Libraries` section.
- Click the `Add Other...` and add `StreamChatCore.framework` in `<Path to your Project>/Carthage/Build/iOS/`.
- Add `StreamChat.framework` if you need UI components.
- Open `Build Phases` panel.
- Click the `+` button and select `New Run Script Phase`.
- Set the content to: `/usr/local/bin/carthage copy-frameworks`.   
- Add to `Input Files`:
  - `$(SRCROOT)/Carthage/Build/iOS/StreamChatCore.framework`
  - `$(SRCROOT)/Carthage/Build/iOS/StreamChat.framework`
- Add to `Output Files`:
  - `$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/StreamChatCore.framework`
  - `$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/StreamChat.framework`
  
  Now build your app.

## Documentation

[Official API Docs](https://getstream.io/chat/docs)

[Core API Reference](https://getstream.github.io/stream-chat-swift/core)

[UI API Reference](https://getstream.github.io/stream-chat-swift/ui)

[Getting started tutorial](https://getstream.io/chat/ios-chat/tutorial/)

## Supported features

- A group chat
- Channel list
- Reactions
- A link preview
- Attach images, videos or files
- Commands (e.g. `/giphy`)
- Edit a message
- Typing events
- Read events
- Threads
- Notifications
- Opening a link in the internal browser
- Image gallery
- Supporting Gifs
- Light/Dark styles
- Style customization
- UI customization

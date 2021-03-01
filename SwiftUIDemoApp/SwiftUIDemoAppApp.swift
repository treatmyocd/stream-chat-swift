//
//  SwiftUIDemoAppApp.swift
//  SwiftUIDemoApp
//
//  Created by Igor Rosocha on 2/24/21.
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import SwiftUI
import StreamChatUI

@main
struct SwiftUIDemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ChannelListView().environmentObject(UIConfig())
        }
    }
}

// WIP - UIConfig is a struct but SwiftUI requires it to be a class.

@dynamicMemberLookup
class UIConfig: ObservableObject {
    subscript<T>(dynamicMember keyPath: WritableKeyPath<StreamChatUI.UIConfig, T>) -> T {
        get { StreamChatUI.UIConfig.default[keyPath: keyPath] }
        set { StreamChatUI.UIConfig.default[keyPath: keyPath] = newValue }
    }
}

//
//  ChatChannelListItemView+SwiftUI.swift
//  SwiftUIDemoApp
//
//  Created by Igor Rosocha on 2/25/21.
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

// swiftlint:disable all

@available(iOS 14, *)
public protocol ChatChannelListItemViewSwiftUI_: View {
    associatedtype ExtraData: ExtraDataTypes

    var channel: _ChatChannel<ExtraData>? { get set }
    var currentUserId: UserId? { get set }

    init()
}

@available(iOS 14, *)
extension _ChatChannelListItemViewBase {
    public class SwiftUI<Content: ChatChannelListItemViewSwiftUI_>:
        _ChatChannelListItemViewBase<Content.ExtraData>
    {
        private var view: Content = Content.init()

        var hostingController: UIHostingController<Content>?

        override public func setUp() {
            hostingController = UIHostingController(rootView: view)
        }

        override public func setUpLayout() {
            embed(hostingController!.view)
        }

        override public func updateContent() {
            view.channel = content.channel
            view.currentUserId = content.currentUserId
            
            hostingController?.rootView = view
        }
    }
}

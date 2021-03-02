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
public typealias ChatChannelListItemViewDataSource<ExtraData, Content: ChatChannelListItemViewSwiftUI_> =
    _ChatChannelListItemViewBase<ExtraData>.SwiftUI<Content> where Content.ExtraData == ExtraData

@available(iOS 14, *)
public protocol ChatChannelListItemViewSwiftUI_: View {
    associatedtype ExtraData: ExtraDataTypes
    init(dataSource: ChatChannelListItemViewDataSource<ExtraData, Self>)
}

@available(iOS 14, *)
extension _ChatChannelListItemViewBase {
    public class SwiftUI<Content: ChatChannelListItemViewSwiftUI_>:
        _ChatChannelListItemViewBase<ExtraData>,
        ObservableObject where Content.ExtraData == ExtraData
    {
        var hostingController: UIHostingController<Content>?

        override public func setUp() {
            let view = Content.init(dataSource: self)
            hostingController = UIHostingController(rootView: view)
        }

        override public func setUpLayout() {
            embed(hostingController!.view)
        }

        override public func updateContent() {
            objectWillChange.send()
        }
    }
}

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
    init(dataSource: _ChatChannelListItemView_DataSource<ExtraData>)
}

@available(iOS 14, *)
public class _ChatChannelListItemView_DataSource<ExtraData: ExtraDataTypes>: ObservableObject {
    @Published public var channel: _ChatChannel<ExtraData>?
    @Published public var currentUserId: UserId?
}

@available(iOS 14, *)
public class _ChatChannelListItemView_SwiftUI<Content: ChatChannelListItemViewSwiftUI_, ExtraData>:
    _ChatChannelListItemViewBase<ExtraData> where Content.ExtraData == ExtraData
{
    var hostingController: UIHostingController<Content>?

    lazy var dataSource = _ChatChannelListItemView_DataSource<ExtraData>()

    override public func setUp() {
        let view = Content.init(dataSource: self.dataSource)
        hostingController = UIHostingController(rootView: view)
    }

    override public func setUpLayout() {
        embed(hostingController!.view)
    }

    override public func updateContent() {
        self.dataSource.channel = content.channel
        self.dataSource.currentUserId = content.currentUserId
    }
}

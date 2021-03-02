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
public protocol _ChatChannelListItemViewSwiftUIView: View {
    associatedtype ExtraData: ExtraDataTypes
    init(dataSource: _ChatChannelListItemView<ExtraData>.ObservedObject<Self>)
}

@available(iOS 14, *)
extension _ChatChannelListItemView {

    public typealias ObservedObject<Content: SwiftUIView> = SwiftUIWrapper<Content> where Content.ExtraData == ExtraData

    public typealias SwiftUIView = _ChatChannelListItemViewSwiftUIView

    public class SwiftUIWrapper<Content: SwiftUIView>: _ChatChannelListItemView<ExtraData>, ObservableObject
        where Content.ExtraData == ExtraData
    {
        var hostingController: UIHostingController<Content>?

        public override func defaultAppearance() {}
        public override func setUpAppearance() {}

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

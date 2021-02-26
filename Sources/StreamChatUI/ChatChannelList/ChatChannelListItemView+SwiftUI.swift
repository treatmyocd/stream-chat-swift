//
//  ChatChannelListItemView+SwiftUI.swift
//  SwiftUIDemoApp
//
//  Created by Igor Rosocha on 2/25/21.
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

/// Protocol which wraps `_ChatChannelListItemView` for usage in SwiftUI.
public protocol ChatChannelListItemViewSwiftUI: View {
    associatedtype ExtraData: ExtraDataTypes

    init()
}

/// Protocol representing `_ChatChannelListItemView` in SwiftUI.
public protocol ChatChannelListItemViewSwiftUIView: ChatChannelListItemViewSwiftUI {
    var title: String { get set }
    var subtitle: String { get set }
    var avatarImage: UIImage { get set }
    var timestamp: String { get set }

    var user: _ChatUser<ExtraData.User>? { get set }
    var message: _ChatMessage<ExtraData>? { get set }
    var channel: _ChatChannel<ExtraData>? { get set }
    var messageReaction: _ChatMessageReaction<ExtraData>? { get set }
}

@available(iOS 14, *)
/// `_ChatChannelListItemView` as a SwiftUI component.
public class _ChatChannelListItemView_SwiftUI<Content: ChatChannelListItemViewSwiftUIView, ExtraData: ExtraDataTypes>: _ChatChannelListItemViewBase<ExtraData> {

    // MARK: - Properties

    let hostingController: UIHostingController<Content>

    // MARK: - Intialization

    init() {
        hostingController = UIHostingController(rootView: Content.init())
        
        super.init(frame: .zero)
        
        embed(hostingController.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public helpers

    public override func updateContent() {
        var view = Content.init()

        let namer = uiConfig.channelList.channelNamer.init()

        if let channel = content.channel {
            view.title = namer.name(for: channel, as: content.currentUserId)
        } else {
            view.title = L10n.Channel.Name.missing
        }

        view.subtitle = typingMemberOrLastMessageString ?? ""
        view.timestamp = content.channel?.lastMessageAt?.getFormattedDate(format: "hh:mm a") ?? ""

        hostingController.rootView = view
    }
}

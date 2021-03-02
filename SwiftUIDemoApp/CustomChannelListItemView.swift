//
//  CustomChannelListItemView.swift
//  SwiftUIDemoApp
//
//  Created by Igor Rosocha on 2/24/21.
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import StreamChatUI
import SwiftUI

@available(iOS 14, *)
public struct CustomChannelListItemView: ChatChannelListItemViewSwiftUI_ {
    public typealias ExtraData = NoExtraData

    @EnvironmentObject var uiConfig: UIConfig

    public var channel: _ChatChannel<ExtraData>?
    public var currentUserId: UserId?

    public init() { }

    private var channelName: String? {
        guard let channel = channel, let currentUserId = currentUserId
        else { return nil }

        let namer = uiConfig.channelList.channelNamer.init()
        return namer.name(for: channel, as: currentUserId)
    }

    public var body: some View {
        HStack(spacing: 10) {
//            Image(uiImage: dataSource.channel!.cachedMembers.first!.imageURL)
//                .padding(10)
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(channelName!)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 10)
                Text(channel?.lastMessageAt?.getFormattedDate(format: "hh:mm a") ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 10)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

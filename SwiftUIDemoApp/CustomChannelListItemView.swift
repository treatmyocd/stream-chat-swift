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
public struct CustomChannelListItemView: ChatChannelListItemViewSwiftUIView {
    public var title: String = ""
    public var subtitle: String = ""
    public var timestamp: String = ""
    public var avatarImage: UIImage = UIImage(systemName: "person")!
    
    public init() { }
    
    public var body: some View {
        HStack(spacing: 10) {
            Image(uiImage: avatarImage)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 10)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 10)
            }
            Text(timestamp)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

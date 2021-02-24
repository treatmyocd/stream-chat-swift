//
//  CustomChannelListItemView.swift
//  SwiftUIDemoApp
//
//  Created by Igor Rosocha on 2/24/21.
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import StreamChatUI
import UIKit

final class CustomChannelListItemView: _ChatChannelListItemView<NoExtraData> {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        subtitleLabel.isHidden = true
        timestampLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

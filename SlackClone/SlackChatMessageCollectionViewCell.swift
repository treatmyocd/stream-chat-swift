//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import StreamChatUI
import UIKit

final class SlackСhatMessageCollectionViewCell: СhatMessageCollectionViewCell {
    override class var messageContentViewClass: _ChatMessageContentView<NoExtraData>.Type { SlackChatMessageContentView.self }
    
    override func setUpLayout() {
        super.setUpLayout()

        NSLayoutConstraint.activate([
            messageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

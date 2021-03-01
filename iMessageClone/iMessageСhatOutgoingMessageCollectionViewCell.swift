//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatUI

final class iMessageСhatOutgoingMessageCollectionViewCell: СhatMessageCollectionViewCell {
    override func setUpLayout() {
        super.setUpLayout()
        
        messageView.messageBubbleView.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            messageView.messageBubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: messageView.leadingAnchor),
            messageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
}

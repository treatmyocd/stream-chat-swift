//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatUI

final class iMessageChatMessageContentView: ChatMessageContentView {
    override func setUpLayout() {
        super.setUpLayout()

        // Does not help => change `messageBubbleView.leadingAnchor.pin(equalTo: leadingAnchor),`?
        messageBubbleView.setContentHuggingPriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            messageMetadataView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        messageMetadataView.timestampLabel.textAlignment = .center
    }
    
    override func updateContent() {
        super.updateContent()

        if message?.type == .ephemeral {
            messageBubbleView.backgroundColor = .systemBlue
        }
        // Not really possible
//        else if layoutOptions.contains(.linkPreview) {
//            backgroundColor = uiConfig.colorPalette.highlightedAccentBackground1
//        }
        else {
            messageBubbleView.backgroundColor = message?.isSentByCurrentUser == true ? .systemGray : .systemBlue
        }
    }
}

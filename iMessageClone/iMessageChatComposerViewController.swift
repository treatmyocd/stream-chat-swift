//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatUI

final class iMessageChatComposerViewController: ChatMessageComposerVC {
    override func promptSuggestionIfNeeded(for text: String) {
    }
    
    override func setUp() {
        super.setUp()

        
    }
    
    override func updateContent() {
        super.updateContent()
        
        switch state {
        case .initial:
            textView.placeholderLabel.text = "iMessage"
        case .edit:
            break
        case .slashCommand, .quote:
            break
        }
    }
}

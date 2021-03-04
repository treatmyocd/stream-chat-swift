//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatUI

final class iMessageCellSeparatorView: CellSeparatorReusableView {
    override func setUpLayout() {
        super.setUpLayout()
        
        NSLayoutConstraint.activate([
//            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            separatorView.heightAnchor.constraint(equalToConstant: 4),
        ])
    }
}

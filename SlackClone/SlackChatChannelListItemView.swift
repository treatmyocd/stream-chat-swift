//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChatUI

final class SlackChatChannelListItemView: ChatChannelListItemView {
    private lazy var _timestampLabel = UILabel()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        avatarView.layer.cornerRadius = 4
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        let topStackView = UIStackView()
        topStackView.spacing = 14
        topStackView.alignment = .center
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        cellContentView.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 9),
            topStackView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            topStackView.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -20),
        ])

        topStackView.addArrangedSubview(titleLabel)

        NSLayoutConstraint.deactivate(layout.timestampLabelConstraints)
        topStackView.addArrangedSubview(timestampLabel)
        NSLayoutConstraint.activate([
            timestampLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
        ])
        
        NSLayoutConstraint.deactivate(layout.unreadCountViewConstraints)
        NSLayoutConstraint.activate([
            unreadCountView.topAnchor.constraint(equalTo: timestampLabel.bottomAnchor),
            unreadCountView.trailingAnchor.constraint(equalTo: timestampLabel.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            avatarView.heightAnchor.constraint(equalToConstant: 35),
            avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }
    
    override func updateContent() {
        super.updateContent()

    }
}

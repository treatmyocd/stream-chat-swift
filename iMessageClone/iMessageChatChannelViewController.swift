//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatUI

final class iMessageChatChannelViewController: ChatChannelVC {
    override func setUpAppearance() {
        super.setUpAppearance()
        
        guard let channel = channelController.channel else { return }
     
        let titleStackView = UIStackView()
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.spacing = 3
        titleStackView.isLayoutMarginsRelativeArrangement = true
        
        let avatar = ChatChannelAvatarView()
        avatar.content = .channelAndUserId(channel: channel, currentUserId: channelController.client.currentUserId)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addArrangedSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 25),
            avatar.widthAnchor.constraint(equalTo: avatar.heightAnchor),
        ])
        
        let titleLabel = UILabel()
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.textColor = .black
        titleLabel.text = ChatChannelNamer().name(for: channel, as: channelController.client.currentUserId)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleStackView.addArrangedSubview(titleLabel)
        
        navigationItem.titleView = titleStackView
        
        navigationItem.rightBarButtonItem = nil
    }
    
    override func updateContent() {
        super.updateContent()
    }
}

final class iMessageChatChannelListRouter: ChatChannelListRouter {
    override func openChat(for channel: _ChatChannel<NoExtraData>) {
        let vc = iMessageChatChannelViewController()
        vc.channelController = rootViewController.controller.client.channelController(for: channel.cid)
        
        guard let navController = navigationController else {
            log.error("Can't push chat detail, no navigation controller available")
            return
        }
        
        navController.show(vc, sender: self)
    }
}

//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatUI

final class SlackChatChannelListViewController: ChatChannelListVC {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let channelListController = ChatClient
            .shared
            .channelListController(
                query: ChannelListQuery(
                    filter: .containMembers(
                        userIds: [ChatClient.shared.currentUserId!]
                    )
                )
            )
        self.controller = channelListController
    }
    
    override func setUp() {
        super.setUp()
        
        createNewChannelButton.addTarget(self, action: #selector(didTapCreateNewChannel), for: .touchUpInside)
    }
    
    override func setUpLayout() {
        let titleView = UIView()
        titleView.backgroundColor = Colors.primary
        titleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "Direct messages"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -15),
        ])
        
        collectionView.contentInset.top = 50
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let jumpView = JumpView()
        jumpView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jumpView)
        NSLayoutConstraint.activate([
            jumpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            jumpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            jumpView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
        ])
        
        let createNewChannelView = UIView()
        createNewChannelView.backgroundColor = Colors.primary
        createNewChannelView.layer.masksToBounds = true
        createNewChannelView.layer.cornerRadius = 30
        createNewChannelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createNewChannelView)
        NSLayoutConstraint.activate([
            createNewChannelView.heightAnchor.constraint(equalToConstant: 60),
            createNewChannelView.widthAnchor.constraint(equalTo: createNewChannelView.heightAnchor),
            createNewChannelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            createNewChannelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])

        createNewChannelButton.translatesAutoresizingMaskIntoConstraints = false
        createNewChannelView.addSubview(createNewChannelButton)
        NSLayoutConstraint.activate([
            createNewChannelButton.topAnchor.constraint(equalTo: createNewChannelView.topAnchor, constant: 10),
            createNewChannelButton.bottomAnchor.constraint(equalTo: createNewChannelView.bottomAnchor, constant: -10),
            createNewChannelButton.leadingAnchor.constraint(equalTo: createNewChannelView.leadingAnchor, constant: 10),
            createNewChannelButton.trailingAnchor.constraint(equalTo: createNewChannelView.trailingAnchor, constant: -10),
        ])
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()

        navigationItem.rightBarButtonItem = nil
        
        userAvatarView.isHidden = true
        navigationItem.searchController = UISearchController()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        
        view.directionalLayoutMargins.leading = 24
        
        createNewChannelButton.setImage(
            UIImage(named: "new_message"),
            for: .normal
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    @objc
    private func editButtonTapped() {
    }
}

private final class JumpView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.background
        
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = Colors.border.cgColor
        layer.borderWidth = 1
        
        let label = UILabel()
        label.textColor = Colors.text
        label.text = "Jump to..."
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

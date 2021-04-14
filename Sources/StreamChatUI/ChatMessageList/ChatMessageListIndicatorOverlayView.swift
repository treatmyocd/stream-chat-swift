//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

/// An `UIView` subclass indicating that user or multiple users are currently typing.
public typealias ChatMessageListTypingIndicatorView = _ChatMessageListTypingIndicatorView<NoExtraData>

/// An `UIView` subclass indicating that user or multiple users are currently typing.
open class _ChatMessageListTypingIndicatorView<ExtraData: ExtraDataTypes>: _View, UIConfigProvider {
    var content: String? {
        didSet {
            updateContentIfNeeded()
        }
    }

    /// The animated view with three dots indicating that someone is typing.
    open private(set) lazy var typingAnimationView: _ChatTypingIndicatorView<ExtraData> = uiConfig
        .typingAnimationView
        .init()
        .withoutAutoresizingMaskConstraints

    /// Label describing who is currently typing
    /// `User is typing`
    /// `User and 3 more are typing`
    open private(set) lazy var informationLabel: UILabel = UILabel().withoutAutoresizingMaskConstraints

    /// StackView holding `typingIndicatorView` and `informationLabel`
    open private(set) lazy var componentStackView: UIStackView = UIStackView().withoutAutoresizingMaskConstraints

    override open func setUp() {
        typingAnimationView.startAnimating()
    }

    override open func setUpLayout() {
        super.setUpLayout()
        embed(componentStackView)
        componentStackView.addArrangedSubview(typingAnimationView)

        componentStackView.addArrangedSubview(informationLabel)
        componentStackView.distribution = .fill
        componentStackView.alignment = .center

        typingAnimationView.heightAnchor.pin(equalToConstant: 5).isActive = true
        typingAnimationView.centerYAnchor.pin(equalTo: centerYAnchor).isActive = true
    }

    override public func defaultAppearance() {
        backgroundColor = uiConfig.colorPalette.overlayBackground
        informationLabel.textColor = uiConfig.colorPalette.subtitleText
        informationLabel.font = uiConfig.font.body
    }

    override open func updateContent() {
        informationLabel.text = content
    }
}

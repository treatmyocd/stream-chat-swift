//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

/// A `UIView` subclass with 3 dots which can be animated with fading out effect.
public typealias ChatTypingIndicatorView = _ChatTypingIndicatorView<NoExtraData>

/// A `UIView` subclass with 3 dots which can be animated with fading out effect.
open class _ChatTypingIndicatorView<ExtraData: ExtraDataTypes>: _View, UIConfigProvider {
    open var dotSize: CGSize = .init(width: 5, height: 5)

    private(set) lazy var innerView: UIView = UIView().withoutAutoresizingMaskConstraints

    private let numberOfDots: Int = 3
    private let dotSpacing: CGFloat = 1.5

    /// Defines the width of the view by counting the number of dots, layer width + spacing and margins from both sides.
    private var viewWidthConstant: CGFloat {
        dotLayer.frame.size.width * dotSpacing * CGFloat(numberOfDots) + directionalLayoutMargins.leading * 2
    }

    open private(set) lazy var dotLayer: CALayer = {
        let layer = CALayer()

        layer.frame.size = dotSize

        layer.cornerRadius = dotSize.height / 2
        return layer
    }()

    open private(set) lazy var replicatorLayer = CAReplicatorLayer()

    override open func setUpLayout() {
        super.setUpLayout()
        innerView.pin(to: layoutMarginsGuide)

        widthAnchor.pin(equalToConstant: viewWidthConstant).isActive = true
        innerView.centerYAnchor.pin(equalTo: centerYAnchor).isActive = true

        dotLayer.position.y = innerView.frame.midY
    }

    override public func defaultAppearance() {
        backgroundColor = .clear
        dotLayer.backgroundColor = uiConfig.colorPalette.text.cgColor
    }

    open func startAnimating() {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.3
        opacityAnimation.duration = 1.0
        opacityAnimation.repeatCount = .infinity

        replicatorLayer.addSublayer(dotLayer)

        replicatorLayer.instanceCount = numberOfDots
        // Add spacing 0.5 times the dot between them
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation((dotLayer.frame.size.width) * dotSpacing, 0, 0)

        replicatorLayer.instanceDelay = opacityAnimation.duration / Double(replicatorLayer.instanceCount)
        innerView.layer.addSublayer(replicatorLayer)

        dotLayer.add(opacityAnimation, forKey: "Typing indicator")
    }
}

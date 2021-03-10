//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

@available(iOS 13.0, *)
/// A `UIViewControllerRepresentable` subclass which wraps `_ChatChannelVC
// TODO: Naming - can't be just ChatChannel
public typealias ChatChannelView = _ChatChannelVC<NoExtraData>.View

extension _ChatChannelVC {
    /// A `UIViewControllerRepresentable` subclass which wraps `ChatChannelListVC` and shows list of channels.
    public struct View: UIViewControllerRepresentable {
        /// The `_ChatChannelController` instance that provides chat channel data.
        let channelController: _ChatChannelController<ExtraData>

        public init(channelController: _ChatChannelController<ExtraData>) {
            self.channelController = channelController
        }

        public func makeUIViewController(context: Context) -> _ChatChannelVC<ExtraData> {
            let vc = _ChatChannelVC<ExtraData>()
            vc.channelController = channelController

            return vc
        }

        public func updateUIViewController(_ chatChannelListVC: _ChatChannelVC<ExtraData>, context: Context) {}
    }
}

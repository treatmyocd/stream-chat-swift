//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

public typealias Chat = _ChatVC<NoExtraData>.View

extension _ChatVC {
    /// A `UIViewControllerRepresentable` subclass which wraps `_ChatVC`.
    public struct View: UIViewControllerRepresentable {
        /// The `_ChatChannelController` instance that provides chat channel data.
        let controller: _ChatChannelController<ExtraData>

        public init(controller: _ChatChannelController<ExtraData>) {
            self.controller = controller
        }

        public func makeUIViewController(context: Context) -> _ChatVC<ExtraData> {
            let vc = _ChatVC<ExtraData>()
            vc.channelController = controller
            
            return vc
        }

        public func updateUIViewController(_ chatChannelListVC: _ChatVC<ExtraData>, context: Context) {}
    }
}

//
//  ChatChannelListVC+SwiftUI.swift
//  StreamChatUI
//
//  Created by Igor Rosocha on 2/24/21.
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import SwiftUI
import StreamChat
import UIKit

@available(iOS 14.0, *)
/// A `UIViewControllerRepresentable` subclass which wraps `ChatChannelListVC`.
public struct ChatChannelListItemVCComponent<ExtraData: ExtraDataTypes>: UIViewControllerRepresentable {
    /// The `ChatChannelListController` instance that provides channels data.
    let controller: ChatChannelListController
    
    public init(controller: ChatChannelListController) {
        self.controller = controller
    }
    
    public func makeUIViewController(context: Context) -> _ChatChannelListVC<NoExtraData> {
        let vc = _ChatChannelListVC<NoExtraData>()
        vc.controller = controller

        return vc
    }
    
    public func updateUIViewController(_ chatChannelListVC: _ChatChannelListVC<NoExtraData>, context: Context) {

    }
}

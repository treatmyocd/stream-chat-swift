//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

public typealias ChatMessageActionsRouter = _ChatMessageActionsRouter<NoExtraData>

open class _ChatMessageActionsRouter<ExtraData: ExtraDataTypes>: ChatRouter<_ChatMessageActionsVC<ExtraData>> {
    open func showMessageDeletionConfirmationAlert(confirmed: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
            title: L10n.Message.Actions.Delete.confirmationTitle,
            message: L10n.Message.Actions.Delete.confirmationMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: L10n.Alert.Actions.cancel,
            style: .cancel,
            handler: { _ in confirmed(false) }
        ))
        alert.addAction(UIAlertAction(
            title: L10n.Alert.Actions.delete,
            style: .destructive,
            handler: { _ in confirmed(true) }
        ))

        rootViewController.present(alert, animated: true)
    }
}

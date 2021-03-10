//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildViewController(_ child: UIViewController, targetView superview: UIView) {
        child.willMove(toParent: self)
        addChild(child)
        superview.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeFromParentViewController() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    var isUIHostingController: Bool {
        String(describing: self).contains("UIHostingController")
    }

    /// Helper method to correctly setup navigation of parent.
    /// Used when view is wrapped using `UIHostingController` and used in SwiftUI
    /// so all properties of `navigationItem` are propagated correctly.
    @available(iOS 13.0, *)
    func setupParentNavigation(parent: UIViewController) {
        let parentNavItem = parent.navigationItem

        if parentNavItem.backBarButtonItem == nil {
            parentNavItem.backBarButtonItem = navigationItem.backBarButtonItem
        }

        if #available(iOS 14.0, *) {
            parent.navigationItem.backButtonDisplayMode = navigationItem.backButtonDisplayMode
        }

        if parentNavItem.backButtonTitle == nil {
            parentNavItem.backButtonTitle = navigationItem.backButtonTitle
        }

        if parentNavItem.compactAppearance == nil {
            parentNavItem.compactAppearance = navigationItem.compactAppearance
        }

        parent.navigationItem.hidesSearchBarWhenScrolling = navigationItem.hidesSearchBarWhenScrolling

        if parent.navigationItem.largeTitleDisplayMode == .automatic {
            parentNavItem.largeTitleDisplayMode = navigationItem.largeTitleDisplayMode
        }

        if parent.navigationItem.hidesBackButton == false {
            parent.navigationItem.hidesBackButton = navigationItem.hidesBackButton
        }

        if let leftBarButtonItems = parentNavItem.leftBarButtonItems, leftBarButtonItems.isEmpty {
            parentNavItem.leftBarButtonItems = navigationItem.leftBarButtonItems
        }

        parent.navigationItem.leftItemsSupplementBackButton = false

        if parentNavItem.prompt == nil {
            parentNavItem.prompt = navigationItem.prompt
        }

        if let rightBarButtonItems = parentNavItem.rightBarButtonItems, rightBarButtonItems.isEmpty {
            parentNavItem.rightBarButtonItems = navigationItem.rightBarButtonItems
        }

        if parentNavItem.scrollEdgeAppearance == nil {
            parentNavItem.scrollEdgeAppearance = navigationItem.scrollEdgeAppearance
        }

        if parentNavItem.searchController == nil {
            parentNavItem.searchController = navigationItem.searchController
        }

        if parentNavItem.standardAppearance == nil {
            parentNavItem.standardAppearance = navigationItem.standardAppearance
        }

        if parentNavItem.title == nil {
            parentNavItem.title = title
        }

        if parentNavItem.titleView == nil {
            parentNavItem.titleView = navigationItem.titleView
        }
    }
}

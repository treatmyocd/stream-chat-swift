//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit

enum Colors {
    static let primary = UIColor(hex: 0x611f69)
    static let background = UIColor.white
    static let border = UIColor(hex: 0xD3D3D3)
    static let text = UIColor.black
}

extension UIColor {
    /**
     Initialize color from hex int (eg. 0xff00ff).
     - parameter hex: Hex int to create color from
     */
    convenience init(hex: UInt32) {
        self.init(
            red: CGFloat(Double((hex & 0xFF0000) >> 16) / 255.0),
            green: CGFloat(Double((hex & 0xFF00) >> 8) / 255.0),
            blue: CGFloat(Double(hex & 0xFF) / 255.0),
            alpha: 1.0
        )
    }
}

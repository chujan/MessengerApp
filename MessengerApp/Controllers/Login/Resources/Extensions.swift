//
//  Extensions.swift
//  MessengerApp
//
//  Created by Chukwuemeka Jennifer on 05/08/2021.
//

import Foundation
import UIKit

extension UIView {
    public var width: CGFloat {
        return frame.size.width
    }
    public var height: CGFloat {
        return frame.size.height
    }
    public var top: CGFloat {
        return frame.origin.y
    }
    public var bottom: CGFloat {
        return frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat {
        return frame.origin.x
    }
    public var right: CGFloat {
        return frame.size.width + frame.origin.x
    }

}
extension Notification.Name {
    /// Notification when users login
    static let didLogInNotification = Notification.Name("didLogInNotification")
}


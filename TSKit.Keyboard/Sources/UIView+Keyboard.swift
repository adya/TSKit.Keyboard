/// - Since: 8/19/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Keyboard/blob/master/LICENSE.md

import UIKit

// MARK: - UIView animation
public extension UIView {

    class func animate(along keyboard: Keyboard,
                       delay: TimeInterval = 0,
                       animations: @escaping () -> Void,
                       completion: ((Bool) -> Void)?) {

        UIView.animate(withDuration: keyboard.animationDuration,
                       delay: delay,
                       options: keyboard.animationOptions,
                       animations: animations,
                       completion: completion)
    }

    class func animate(along keyboard: Keyboard,
                       delay: TimeInterval = 0,
                       animations: @escaping () -> Void) {
        animate(along: keyboard, delay: delay, animations: animations, completion: nil)
    }
}

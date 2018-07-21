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

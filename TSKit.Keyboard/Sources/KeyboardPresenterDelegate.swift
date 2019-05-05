/// - Since: 8/19/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Keyboard/blob/master/LICENSE.md

import CoreGraphics

/// Conformance to `KeyboardPresenterDelegate` enables conforming object to adopt keyboard behavior.
public protocol KeyboardPresenterDelegate: class {

    /// Tells the `delegate` that keyboard is about to appear.
    /// - Parameter keyboard: `Keyboard` object with appearence properties.
    func keyboardPresenter(_ presenter: KeyboardPresenter, willPresent keyboard: Keyboard)

    /// Tells the `delegate` that keyboard has appeared.
    /// - Parameter keyboard: `Keyboard` object with appearence properties.
    func keyboardPresenter(_ presenter: KeyboardPresenter, didPresent keyboard: Keyboard)

    /// Tells the `delegate` that keyboard is about to disappear.
    /// - Parameter keyboard: `Keyboard` object with appearence properties.
    func keyboardPresenter(_ presenter: KeyboardPresenter, willHide keyboard: Keyboard)

    /// Asks the `delegate` for offset that should be preserved when presenting keyboard.
    /// - Parameter keyboard: `Keyboard` object with appearence properties.
    /// - Returns: An offset preserved between keyboard and both bottom guide and first responder.
    func keyboardPresenter(_ presenter: KeyboardPresenter,
                           offsetWhenPresenting keyboard: Keyboard) -> CGFloat

    // TODO: Figure out a way to incapsulate presentation logic
    /// Asks the `delegate` for bottom guide's vertical position.
    /// This guide is used to calculate possible view overlap by keyboard.
    /// - Returns: `y` position of the guide.
    func keyboardPresenterContentBottomGuide(_ presenter: KeyboardPresenter) -> CGFloat

    /// Tells the `delegate` that keyboard will overlap the bottom guide.
    /// Use this method to adjust your content to avoid overlap.
    /// - Parameter overlap: Distance between `minY` coordinate of the `keyboard` and the bottom guide when `keyboard` overlaps it.
    /// - Parameter keyboard: `Keyboard` object with appearence properties.
    func keyboardPresenter(_ presenter: KeyboardPresenter,
                           willOverlapGuideFor overlap: CGFloat,
                           whenPresenting keyboard: Keyboard)

    /// Tells the `delegate` that keyboard will overlap the first responder.
    /// Use this method to adjust your content to avoid overlap.
    /// - Parameter overlap: Distance between `minY` coordinate of the `keyboard` and `maxY` of the first responder when `keyboard` overlaps it.
    /// - Parameter keyboard: `Keyboard` object with appearence properties.
    func keyboardPresenter(_ presenter: KeyboardPresenter,
                           willOverlapFirstResponderFor overlap: CGFloat,
                           whenPresenting keyboard: Keyboard)
}

// MARK: - Defaults
public extension KeyboardPresenterDelegate {

    func keyboardPresenter(_ presenter: KeyboardPresenter, willPresent keyboard: Keyboard) {}

    func keyboardPresenter(_ presenter: KeyboardPresenter, didPresent keyboard: Keyboard) {}

    func keyboardPresenter(_ presenter: KeyboardPresenter, willHide keyboard: Keyboard) {}

    func keyboardPresenter(_ presenter: KeyboardPresenter,
                           offsetWhenPresenting keyboard: Keyboard) -> CGFloat {
        return 16.0
    }

    func keyboardPresenter(_ presenter: KeyboardPresenter,
                           willOverlapGuideFor overlap: CGFloat,
                           whenPresenting keyboard: Keyboard) {}

    func keyboardPresenter(_ presenter: KeyboardPresenter,
                           willOverlapFirstResponderFor overlap: CGFloat,
                           whenPresenting keyboard: Keyboard) {}
}

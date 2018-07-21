import UIKit

public class KeyboardPresenter {

    /// Flag indicating whether tapping outside of keyboard should dismiss it. Defaults to `true`.
    public var tapShouldDismiss: Bool = true

    public var isShiftAnimated: Bool = true

    public weak var delegate: KeyboardPresenterDelegate?

    fileprivate unowned let controller: UIViewController

    fileprivate var gesture: UIGestureRecognizer!

    public init(for controller: UIViewController) {
        self.controller = controller
        gesture = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        controller.view.addGestureRecognizer(gesture)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: .UIKeyboardWillShow,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow),
                                               name: .UIKeyboardDidShow,
                                               object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    fileprivate func keyboardWillAppear(_ keyboard: Keyboard) {
        let keyboardOffset = delegate?.keyboardPresenter(self, offsetWhenPresenting: keyboard) ?? 0

        if let responder = firstResponder {
            let responderBottom = responder.convert(responder.frame, to: controller.view).maxY
            let responderOverlap = (responderBottom + keyboardOffset) - keyboard.endFrame.origin.y

            if responderOverlap > 0 {
                delegate?.keyboardPresenter(self,
                                            willOverlapFirstResponderFor: responderOverlap,
                                            whenPresenting: keyboard)
            }
        }

        let bottomGuide = delegate?.keyboardPresenterContentBottomGuide(self) ?? controller.view.frame.maxY
        let guideOverlap = (bottomGuide + keyboardOffset) - keyboard.endFrame.origin.y
        if guideOverlap > 0 {
            delegate?.keyboardPresenter(self, willOverlapGuideFor: guideOverlap, whenPresenting: keyboard)
        }
    }

    fileprivate func keyboardWillDisappear(_ keyboard: Keyboard) {

    }

    /// Finds current `firstResponder` for which keyboard is appearing.
    private var firstResponder: UIView? {
        func firstResponder(in root: UIView) -> UIView? {
            if root.isFirstResponder { return root }

            for view in root.subviews {
                if let firstResponder = firstResponder(in: view) {
                    return firstResponder
                }
            }
            return nil
        }

        return firstResponder(in: controller.view)
    }
}

// MARK: - Keyboard
private extension KeyboardPresenter {

    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        guard tapShouldDismiss else {
            return
        }
        controller.view.endEditing(true)
    }

    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboard = Keyboard(userInfo: userInfo) else {
            return
        }
        delegate?.keyboardPresenter(self, willPresent: keyboard)
        keyboardWillAppear(keyboard)
    }

    @objc
    func keyboardDidShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboard = Keyboard(userInfo: userInfo) else {
            return
        }
        delegate?.keyboardPresenter(self, didPresent: keyboard)
    }

    @objc
    func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboard = Keyboard(userInfo: userInfo) else {
            return
        }
        delegate?.keyboardPresenter(self, willHide: keyboard)
    }
}

// MARK: - Keyboard initializer
private extension Keyboard {

    init?(userInfo: [AnyHashable : Any]) {
        guard let beginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
              let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
              let animation = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            return nil
        }
        if #available(iOS 9.0, *) {
            guard let isLocal = (userInfo[UIKeyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue else {
                return nil
            }
            self.isLocal = isLocal
        } else {
            self.isLocal = true
        }

        self.beginFrame = beginFrame
        self.endFrame = endFrame
        self.animationDuration = duration
        self.animationOptions = UIViewAnimationOptions(rawValue: animation)

    }
}

private extension UIViewAnimationOptions {

    init(curve: UIViewAnimationCurve) {
        switch curve {
        case .easeIn:
            self = .curveEaseIn
        case .easeOut:
            self = .curveEaseOut
        case .easeInOut:
            self = .curveEaseInOut
        case .linear:
            self = .curveLinear
        }
    }
}

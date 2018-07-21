import UIKit

/// An object containing information about keyboard appearance.
public struct Keyboard {
    
    /// CGRect that identifies the starting frame rectangle of the keyboard in screen coordinates.
    /// The frame rectangle reflects the current orientation of the device.
    public let beginFrame: CGRect
    
    ///CGRect that identifies the ending frame rectangle of the keyboard in screen coordinates.
    ///The frame rectangle reflects the current orientation of the device.
    public let endFrame: CGRect
    
    /// The duration of the animation in seconds.
    public let animationDuration: TimeInterval
    
    /// `UIViewAnimationOptions` constant that defines how the keyboard will be animated onto or off the screen.
    public let animationOptions: UIViewAnimationOptions
    
    /**
     Flag that identifies whether the keyboard belongs to the current app.
     With multitasking on iPad, all visible apps are notified when the keyboard appears and disappears.
     The value of this key is `true` for the app that caused the keyboard to appear and `false` for any other apps.
     - Important: This flag available in `iOS 9` and above. In prior version this flag is always `true`.
     */
    public let isLocal: Bool
    
    private init?() { return nil }
}

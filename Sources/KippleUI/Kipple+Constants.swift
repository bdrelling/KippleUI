// Copyright © 2022 Brian Drelling. All rights reserved.

import CoreGraphics
import Foundation
import KippleCore

public extension Kipple {
    /// The default animation speed.
    static let defaultAnimationSpeed = 0.35

    /// The default SwiftUI padding value.
    static let defaultPadding: CGFloat = 16

    /// A convenience alias for the default SwiftUI padding value.
    static let defaultPaddingFull = Self.defaultPadding

    /// A convenience alias for one half of the default SwiftUI padding value.
    static let defaultPaddingHalf = Self.defaultPadding / 2

    /// A convenience alias for one quarter of the default SwiftUI padding value.
    static let defaultPaddingQuarter = Self.defaultPadding / 4

    /// Whether or not this code is running within Xcode SwiftUI Previews, which has limited functionality.
    static let isRunningInXcodePreview: Bool = {
        #if DEBUG
            ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
            false
        #endif
    }()
}

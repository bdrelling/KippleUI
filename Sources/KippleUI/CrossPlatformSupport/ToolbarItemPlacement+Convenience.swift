// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension ToolbarItemPlacement {
    static let crossPlatformTopBarLeading: Self = {
        #if os(macOS)
        .navigation
        #else
        .topBarLeading
        #endif
    }()

    static let crossPlatformTopBarTrailing: Self = {
        #if os(macOS)
        .primaryAction
        #else
        .topBarTrailing
        #endif
    }()
}

// MARK: - Previews

#Preview {
    NavigationStack {
        Color.gray
            .ignoresSafeArea()
            .toolbar {
                #if !os(watchOS)
                ToolbarItem(placement: .navigation) {
                    Text("Navigation")
                }
                ToolbarItem(placement: .principal) {
                    Text("Principal")
                }
                #endif
                ToolbarItem(placement: .destructiveAction) {
                    Text("Destruct")
                }
                ToolbarItem(placement: .cancellationAction) {
                    Text("Cancel")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Text("Confirm")
                }
                ToolbarItem(placement: .primaryAction) {
                    Text("Primary")
                }
                #if !os(tvOS) && !os(watchOS)
                ToolbarItem(placement: .secondaryAction) {
                    Text("Secondary")
                }
                ToolbarItem(placement: .status) {
                    Text("Status")
                }
                #endif
                ToolbarItem(placement: .automatic) {
                    Text("Automatic")
                }
            }
    }
}

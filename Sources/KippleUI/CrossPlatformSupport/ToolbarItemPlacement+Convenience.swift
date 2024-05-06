// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public extension ToolbarItemPlacement {
    static let crossPlatformTopBarLeading: Self = {
        #if os(iOS)
        .topBarLeading
        #elseif os(macOS)
        .navigation
        #endif
    }()

    static let crossPlatformTopBarTrailing: Self = {
        #if os(iOS)
        .topBarTrailing
        #elseif os(macOS)
        .primaryAction
        #endif
    }()
}

// MARK: - Previews

#Preview {
    NavigationStack {
        Color.gray
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Navigation")
                }
                ToolbarItem(placement: .destructiveAction) {
                    Text("Destruct")
                }
                ToolbarItem(placement: .cancellationAction) {
                    Text("Cancel")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Text("Confirm")
                }
                ToolbarItem(placement: .secondaryAction) {
                    Text("Secondary")
                }
                ToolbarItem(placement: .primaryAction) {
                    Text("Primary")
                }
                ToolbarItem(placement: .status) {
                    Text("Status")
                }
                ToolbarItem(placement: .principal) {
                    Text("Principal")
                }
                ToolbarItem(placement: .automatic) {
                    Text("Automatic")
                }
            }
    }
}

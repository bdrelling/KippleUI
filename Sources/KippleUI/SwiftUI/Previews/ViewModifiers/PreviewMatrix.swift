// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public struct PreviewMatrix: ViewModifier {
    public let layouts: [Layout]

    public init(layouts: [Layout]) {
        self.layouts = layouts
    }

    public func body(content: Content) -> some View {
        ForEach(self.layouts, id: \.id) { layout in
            content
                // Set up the preview configuration
                .previewLayout(layout.previewLayout)
                .previewDevice(layout.previewDevice)
                .previewDisplayName(layout.name)
        }
    }
}

// MARK: - ViewModifier Extensions

public extension View {
    func previewMatrix(_ matrix: PreviewMatrix = .default) -> some View {
        self.modifier(matrix)
    }

    @ViewBuilder
    func previewMatrix(_ layouts: [PreviewMatrix.Layout], colorSchemes: [ColorScheme]? = nil) -> some View {
        if let colorSchemes = colorSchemes {
            self.previewMatrix(.init(layouts: layouts))
                .previewMatrix(colorSchemes: colorSchemes)
        } else {
            self.previewMatrix(.init(layouts: layouts))
        }
    }

    func previewMatrix(_ layouts: PreviewMatrix.Layout..., colorSchemes: [ColorScheme]? = nil) -> some View {
        self.previewMatrix(layouts, colorSchemes: colorSchemes)
    }

    func previewMatrix(_ type: PreviewDeviceType) -> some View {
        self.previewMatrix(.init(layouts: .device(type)))
    }

    func previewMatrix(colorSchemes: [ColorScheme]) -> some View {
        ForEach(colorSchemes, id: \.self) { colorScheme in
            self.preferredColorScheme(colorScheme)
        }
    }
}

// MARK: - Previews

struct PreviewMatrix_Previews: PreviewProvider {
    static var previews: some View {
        Text("Testing!")
            .previewMatrix(
                .currentDevice,
                .device(.iPodTouchGen7),
                .fixedSize(width: 200, height: 80),
                .sizeThatFits
            )
    }
}

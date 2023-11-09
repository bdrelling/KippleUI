// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
// Source: https://www.fivestars.blog/articles/reverse-masks-how-to/
public extension View {
    func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}

// MARK: - Previews

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct View_ReverseMask_Previews: PreviewProvider {
    static var previews: some View {
        Color.blue
            .reverseMask {
                Text("Reverse!")
                    .font(.largeTitle.bold())
            }
            .padding()
            .background(.yellow)
    }
}

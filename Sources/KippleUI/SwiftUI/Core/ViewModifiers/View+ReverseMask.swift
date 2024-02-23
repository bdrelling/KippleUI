// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

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

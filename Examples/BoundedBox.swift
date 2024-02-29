// Copyright © 2024 Brian Drelling. All rights reserved.

#if !os(tvOS)

import SwiftUI

private struct Example_BoundedBox: View {
    @State private var position = CGPoint(x: 100, y: 100)

    var body: some View {
        VStack {
            Text("Current postion = (x: \(Int(self.position.x)), y: \(Int(self.position.y)))")

            GeometryReader { geometry in
                self.square
                    .position(self.position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Our position is from the center of the view, so we need to ensure
                                // that our square respects an inset of half its width.
                                let limitedX = max(min(value.location.x, geometry.size.width - 40), 40)
                                let limitedY = max(min(value.location.y, geometry.size.height - 40), 40)

                                self.position = CGPoint(x: limitedX, y: limitedY)
                            }
                    )
            }
            .clipped()
            .background(.secondary)
            .edgesIgnoringSafeArea(.all)
        }
    }

    private var square: some View {
        Rectangle()
            .fill(.primary)
            .contentShape(Rectangle())
            .frame(width: 80, height: 80)
    }
}

// MARK: - Previews

struct Example_BoundedBox_Previews: PreviewProvider {
    static var previews: some View {
        Example_BoundedBox()
    }
}

#endif

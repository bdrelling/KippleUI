// Copyright © 2024 Brian Drelling. All rights reserved.

#if !os(tvOS)

import SwiftUI

private struct Example_BoundedCircle: View {
    @State private var position = CGPoint(x: 100, y: 100)
    private var dragDiametr: CGFloat = 200.0
    var body: some View {
        VStack {
            Text("current position = (x: \(Int(self.position.x)), y: \(Int(self.position.y)))")
            Circle()
                .fill(Color.secondary)
                .frame(width: self.dragDiametr, height: self.dragDiametr)
                .overlay(
                    Circle()
                        .fill(Color.primary)
                        .frame(width: self.dragDiametr / 4, height: self.dragDiametr / 4)
                        .position(x: self.position.x, y: self.position.y)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let currentLocation = value.location
                                    let center = CGPoint(x: dragDiametr / 2, y: dragDiametr / 2)
                                    let distance = center.distance(to: currentLocation)
                                    if distance > self.dragDiametr / 2 {
                                        let k = (dragDiametr / 2) / distance
                                        let newLocationX = (currentLocation.x - center.x) * k + center.x
                                        let newLocationY = (currentLocation.y - center.y) * k + center.y
                                        self.position = CGPoint(x: newLocationX, y: newLocationY)
                                    } else {
                                        self.position = value.location
                                    }
                                }
                        )
                )
        }
    }
}

// MARK: - Previews

struct Example_BoundedCircle_Previews: PreviewProvider {
    static var previews: some View {
        Example_BoundedCircle()
    }
}

#endif

// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

private struct Example_BoundedCircle: View {
    @State private var position = CGPoint(x: 100, y: 100)
    private var dragDiametr: CGFloat = 200.0
    var body: some View {
        VStack {
            Text("current position = (x: \(Int(position.x)), y: \(Int(position.y)))")
            Circle()
                .fill(Color.secondary)
                .frame(width: dragDiametr, height: dragDiametr)
                .overlay(
                    Circle()
                        .fill(Color.primary)
                        .frame(width: dragDiametr / 4, height: dragDiametr / 4)
                        .position(x: position.x, y: position.y)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let currentLocation = value.location
                                    let center = CGPoint(x: self.dragDiametr / 2, y: self.dragDiametr / 2)
                                    let distance = center.distance(to: currentLocation)
                                    if distance > self.dragDiametr / 2 {
                                        let k = (self.dragDiametr / 2) / distance
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

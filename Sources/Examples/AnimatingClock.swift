// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

private struct Example_AnimatingClock: View {
    var hoursOffset: CGFloat

    var body: some View {
        GeometryReader { geo in
            ForEach(0 ..< 12) { hour in
                ZStack {
                    Text("\(hour)")
                        .modifier(CircleMoving(hoursOffset: self.hoursOffset, hour: CGFloat(hour), size: geo.size.width))
                }
            }
        }
        .animation(.easeInOut(duration: 3.0), value: self.hoursOffset) // !!!
    }
}

// MARK: Supporting Types

private struct CircleMoving: ViewModifier, Animatable {
    var hoursOffset: CGFloat
    var hour: CGFloat
    var size: CGFloat

    public var animatableData: CGFloat {
        get { self.hoursOffset }
        set { self.hoursOffset = newValue }
    }

    func body(content: Content) -> some View {
        content
            .position(CGPoint.onCircle(hours: self.hour + self.hoursOffset, size: self.size))
    }
}

// MARK: - Extensions

private extension CGPoint {
    static func onCircle(hours: CGFloat, size: CGFloat) -> CGPoint {
        let radians = (3 - hours) * CGFloat.pi / CGFloat(6)
        let hypotenuse = size / 2
        return CGPoint(x: (size / 2 + 0.8 * hypotenuse * cos(radians)).rounded(.up),
                       y: (size / 2 - 0.8 * hypotenuse * sin(radians)).rounded(.up))
    }
}

// MARK: - Previews

struct Example_AnimatingClock_Previews: PreviewProvider {
    static var previews: some View {
        // Adjust the hours offset manually (quickly!) to see it animate
        Example_AnimatingClock(hoursOffset: 12)
    }
}

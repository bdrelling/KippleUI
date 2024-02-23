// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

// Source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-polygons-and-stars
public struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    private let corners: Int
    private let smoothness: Double

    public func path(in rect: CGRect) -> Path {
        // ensure we have at least two corners, otherwise send back an empty path
        guard self.corners >= 2 else { return Path() }

        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2

        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / Double(self.corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * self.smoothness
        let innerY = center.y * self.smoothness

        // we're ready to start with our path now
        var path = Path()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: Double = 0

        // loop over all our points/inner points
        for corner in 0 ..< self.corners * 2 {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // move on to the next corner
            currentAngle += angleAdjustment
        }

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }

    init(corners: Int = 5, smoothness: Double = 0.45) {
        self.corners = corners
        self.smoothness = smoothness
    }
}

// MARK: - Previews

#Preview {
    Star()
        .fill(.red)
        .aspectRatio(contentMode: .fit)
}

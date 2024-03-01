// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// An animatable shape wrapper that provides out-of-the-box animation styles.
public struct AnimatableShape: Shape {
    // MARK: Properties

    /// The shape to animate.
    private let shape: any Shape

    /// The style to use when animating the shape.
    private let style: Style

    /// The progress of the animation.
    private var progress: CGFloat

    public var animatableData: Double {
        get { self.progress }
        set { self.progress = newValue }
    }

    /// The start point of the shape.
    private var start: CGFloat {
        switch self.style {
        case .draw:
            return 0
        case .drawUndraw:
            return 0
        case .drawErase:
            if self.progress < 0.5 {
                return 0
            } else {
                return (self.progress - 0.5) * 2
            }
        }
    }

    /// The end point of the shape.
    private var end: CGFloat {
        switch self.style {
        case .draw:
            return self.progress
        case .drawUndraw:
            if self.progress < 0.5 {
                return self.progress * 2
            } else {
                return (1 - self.progress) * 2
            }
        case .drawErase:
            return 1 * min(self.progress * 2, 1)
        }
    }

    // MARK: Initializers

    public init(shape: any Shape, style: Style = .drawErase, progress: CGFloat) {
        self.shape = shape
        self.style = style
        self.progress = progress
    }

    // MARK: Methods

    public func path(in rect: CGRect) -> Path {
        // Apply that scale and send back the result.
        self.shape
            .path(in: rect)
            .trimmedPath(from: self.start, to: self.end)
    }
}

// MARK: - Supporting Types

public extension AnimatableShape {
    /// Defines the various styles for animation.
    enum Style: Sendable {
        /// Draws the shape's path once from start to end.
        ///
        /// `progress` between `0...1` shows the line being drawn, with `1` being fully visible.
        case draw

        /// Draws the shape's path once from start to end,
        /// then "undraws" from end to start.
        ///
        /// `progress` between `0...0.5` show the line being drawn, with `0.5` being fully visible.
        /// `progress` between `0.5...1` show the line being undrawn, with `1` being fully invisible again.
        case drawUndraw

        /// Draws the shape's path once from start to end,
        /// then "erases" it from start to end.
        ///
        /// `progress` between `0...0.5` show the line being drawn, with `0.5` being fully visible.
        /// `progress` between `0.5...1` show the line being erased, with `1` being fully invisible again.
        case drawErase
    }
}

// MARK: - Previews

struct AnimatableShape_Previews: PreviewProvider {
    static var previews: some View {
        preview {
            AnimatableShape.Previewer(shape: Circle(), style: .draw)
        }
        .previewDisplayName("Circle - Draw")

        preview {
            AnimatableShape.Previewer(shape: Circle(), style: .drawUndraw)
        }
        .previewDisplayName("Circle - Draw Undraw")

        preview {
            AnimatableShape.Previewer(shape: Circle(), style: .drawErase)
        }
        .previewDisplayName("Circle - Draw Erase")
    }

    @ViewBuilder
    static func preview<Content>(@ViewBuilder content: () -> Content) -> some View where Content: View {
        VStack {
            Spacer()

            content()
                .scaledToFit()

            Spacer()
        }
    }
}

extension AnimatableShape {
    struct Previewer: View {
        @State private var progress: CGFloat = 0.0

        let shape: any Shape
        let style: AnimatableShape.Style
        let speed: TimeInterval = 2
        let color: Color = .white
        let lineWidth: CGFloat = 6

        var body: some View {
            AnimatableShape(shape: self.shape, style: self.style, progress: self.progress)
                .stroke(self.color, style: .init(lineWidth: self.lineWidth, lineCap: .round, lineJoin: .round))
                .onAppear {
                    self.startAnimation()
                }
        }

        private func startAnimation(delay: TimeInterval = 0) {
            // Get our speed value upfront to avoid any race conditions.
            let speed = speed

            // Animation within a NavigationView has issues, so we wrap in a DispatchQueue.main.async call.
            // https://stackoverflow.com/a/64566746/706771
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.progress = 0

                // Animate our progress from 0 to 1
                withAnimation(.easeInOut(duration: speed)) {
                    self.progress = 1.0
                }

                // Queue the next animation, but with a delay that allows the current animation to complete.
                self.startAnimation(delay: speed)
            }
        }
    }
}

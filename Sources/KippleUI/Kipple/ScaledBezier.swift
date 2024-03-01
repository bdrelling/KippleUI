//// Copyright © 2024 Brian Drelling. All rights reserved.
//
//import SwiftUI
//
///// Draws a `UIBezierPath` within a SwiftUI `Shape` context.
/////
///// Source (with modifications): https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-uibezierpath-and-cgpath-in-swiftui
//public struct ScaledBezier: Shape {
//    private let bezierPath: UIBezierPath
//
//    public init(_ bezierPath: UIBezierPath) {
//        self.bezierPath = bezierPath
//    }
//
//    public func path(in rect: CGRect) -> Path {
//        let path = Path(bezierPath.cgPath)
//        return path.scaled(to: rect)
//    }
//}
//
//// MARK: - Extensions
//
//public extension Path {
//    func scaled(to rect: CGRect) -> Path {
//        // Determine the scale of the current path
//        let width = rect.width / boundingRect.width
//        let height = rect.height / boundingRect.height
//
//        // Figure out how much bigger we need to make our path in order for it to fill the available space without clipping.
//        let multiplier = min(width, height)
//
//        // Create an affine transform that uses the multiplier for both dimensions equally.
//        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)
//
//        // Apply that scale and send back the result.
//        return applying(transform)
//    }
//}
//
//// MARK: - Previews
//
//struct ScaledBezier_Previews: PreviewProvider {
//    static var previews: some View {
//        ScaledBezier(.cardiogram)
//            .stroke(Color.white)
//            .background(Color.blue)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}
//
//private extension UIBezierPath {
//    static var cardiogram: UIBezierPath {
//        let path = UIBezierPath()
//        path.move(to: .init(x: 0, y: 0.5))
//        path.addLine(to: .init(x: 0.25, y: 0.5))
//        path.addLine(to: .init(x: 0.3, y: 0.4))
//        path.addLine(to: .init(x: 0.35, y: 0.5))
//        path.addLine(to: .init(x: 0.45, y: 0))
//        path.addLine(to: .init(x: 0.6, y: 0.8))
//        path.addLine(to: .init(x: 0.7, y: 0.4))
//        path.addLine(to: .init(x: 0.75, y: 0.5))
//        path.addLine(to: .init(x: 1, y: 0.5))
//        return path
//    }
//}

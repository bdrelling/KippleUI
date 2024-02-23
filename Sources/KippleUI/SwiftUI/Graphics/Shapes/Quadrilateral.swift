import SwiftUI

public struct Quadrilateral: Shape {
    public let points: [UnitPoint]
    
    public init(points: [UnitPoint] = .quadrilateralDefault) {
        if points.count >= 4 {
            self.points = Array(points.prefix(4))
        } else {
            self.points = .quadrilateralDefault
        }
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for (index, point) in self.points.enumerated() {
            let point = point.in(rect)
            
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.closeSubpath()

        return path
    }
}

// MARK: - Extensions

public extension Array where Element == UnitPoint {
    static let quadrilateralDefault: Self = [.topLeading, .topTrailing, .bottomTrailing, .bottomLeading]
}

extension UnitPoint {
    func `in`(_ rect: CGRect) -> CGPoint {
        .init(
            x: rect.width * self.x,
            y: rect.height * self.y
        )
    }
}

// MARK: - Previews

#Preview {
    VStack {
        Quadrilateral()
            .fill(.red)
            .aspectRatio(contentMode: .fit)
        
        Quadrilateral(points: [.topLeading, .top, .bottomTrailing, .bottomLeading])
            .fill(.red)
            .aspectRatio(contentMode: .fit)
    }
    .padding()
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
private struct StormView: View {
    @State private var storm = Storm()
    let rainColor = Color(red: 0.25, green: 0.5, blue: 0.75)

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                self.storm.update(to: timeline.date)

                for drop in self.storm.drops {
                    let age = timeline.date.distance(to: drop.removalDate)
                    let rect = CGRect(x: drop.x * size.width, y: size.height - (size.height * age * drop.speed), width: 2, height: 10)
                    let shape = Capsule().path(in: rect)
                    context.fill(shape, with: .color(self.rainColor))
                }
            }
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

private struct Raindrop: Hashable, Equatable {
    var x: Double
    var removalDate: Date
    var speed: Double
}

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
@Observable
private class Storm {
    var drops = Set<Raindrop>()

    func update(to date: Date) {
        self.drops = self.drops.filter { $0.removalDate > date }
        self.drops.insert(Raindrop(x: Double.random(in: 0 ... 1), removalDate: date + 1, speed: Double.random(in: 1 ... 2)))
    }
}

// MARK: - Previews

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
struct StormView_Previews: PreviewProvider {
    static var previews: some View {
        StormView()
    }
}

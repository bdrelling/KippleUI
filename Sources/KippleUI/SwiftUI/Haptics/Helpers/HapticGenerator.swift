// Copyright © 2024 Brian Drelling. All rights reserved.

import Combine
import CoreHaptics

public final class HapticGenerator {
    // MARK: Properties

    public static let shared = HapticGenerator()

    private var hapticEngine: CHHapticEngine?

    public var supportsHaptics: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }

    // MARK: Initializers

    private init() {
        self.initialize()
    }

    // MARK: Methods

    private func initialize() {
        guard self.supportsHaptics else { return }

        do {
            let hapticEngine = try CHHapticEngine()
            hapticEngine.isAutoShutdownEnabled = true

            self.hapticEngine = hapticEngine
        } catch {
            print("InvestorDemo: Error initializing haptics engine - \(error)")
        }
    }

    private func play(pattern: CHHapticPattern, delay: TimeInterval = CHHapticTimeImmediate) throws {
        guard self.supportsHaptics else {
            return
        }

        guard let hapticEngine else {
            throw HapticError.engineNotInitialized
        }

        try hapticEngine.start()
        let player = try hapticEngine.makePlayer(with: pattern)
        try player.start(atTime: delay)

        hapticEngine.notifyWhenPlayersFinished { _ in
            .stopEngine
        }
    }

    public func tap() throws {
        try self.play(pattern: .tap())
    }

    public func rumble(duration: TimeInterval) throws {
        try self.play(pattern: .rumble(duration: duration))
    }

    public func stop() {
        self.hapticEngine?.stop()
    }

    deinit {
        self.stop()
    }
}

// MARK: - Supporting Types

public enum HapticError: Error {
    case engineNotInitialized
}

// MARK: - Extensions

public extension CHHapticPattern {
    static func tap() throws -> CHHapticPattern {
        try .init(
            events: [
                .init(intensity: 2, sharpness: 0.2, relativeTime: 0),
            ],
            parameters: []
        )
    }

    static func rumble(duration: TimeInterval) throws -> CHHapticPattern {
        try .init(
            events: [
                .init(eventType: .hapticContinuous, intensity: 2, sharpness: 0.2, relativeTime: 0, duration: duration),
            ],
            parameters: []
        )
    }
}

public extension CHHapticEvent {
    /// Initializes a haptic event of the specified type, intensity, sharpness, start time, and duration.
    /// - Parameters:
    ///   - eventType: The type of the haptic event: transient or continuous.
    ///   - intensity: The strength of the haptic event.
    ///   - sharpness: The feel of the haptic event.
    ///   - relativeTime: The start time of the haptic event, in seconds.
    ///   - duration: The duration of the haptic event, in seconds.
    convenience init(
        eventType: EventType = .hapticTransient,
        intensity: Float,
        sharpness: Float,
        relativeTime: TimeInterval,
        duration: TimeInterval = 0
    ) {
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)

        self.init(
            eventType: eventType,
            parameters: [
                intensityParameter,
                sharpnessParameter,
            ],
            relativeTime: relativeTime,
            duration: duration
        )
    }
}

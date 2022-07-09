// Copyright © 2022 Brian Drelling. All rights reserved.

import CoreMotion
import SwiftUI

@available(macOS, unavailable)
public struct ParallaxMotionModifier: ViewModifier {
    @ObservedObject public var manager: MotionManager

    public var magnitude: Double

    public func body(content: Content) -> some View {
        content
            .offset(
                x: CGFloat(self.manager.roll * self.magnitude),
                y: CGFloat(self.manager.pitch * self.magnitude)
            )
    }

    public init(manager: MotionManager, magnitude: Double) {
        self.manager = manager
        self.magnitude = magnitude
    }
}

@available(macOS, unavailable)
public class MotionManager: ObservableObject {
    @Published public var pitch: Double = 0.0
    @Published public var roll: Double = 0.0

    private var manager: CMMotionManager

    public init() {
        self.manager = CMMotionManager()

        // Update the device motion handler one sixtieth of a second.
        self.manager.deviceMotionUpdateInterval = 1 / 10

        self.manager.startDeviceMotionUpdates(to: .main) { motionData, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let motionData = motionData {
                // Gimbal lock is when the yaw and roll to match up when the pitch is roughly 90 degrees, causing the gyro to lose a degree of freedom.
                // Because of this, we add the roll and yaw together, which should keep the output roll for rocketing upwards.
                // Source: https://stackoverflow.com/a/17931490/706771

                let yawDegrees = motionData.attitude.yaw * (180.0 / .pi)
                let pitchDegrees = motionData.attitude.pitch * (180.0 / .pi)
                let rollDegrees = motionData.attitude.roll * (180.0 / .pi)

                let rotationDegrees = yawDegrees + rollDegrees
                let rollDegreesModified: Double

                // This is the condition where simply summing yawDegrees with rollDegrees wouldn't work.
                // Suppose yaw = -177 and pitch = -165, rotationDegrees would then be -342, making your rotation angle jump all the way around the circle.
                if abs(rotationDegrees) > 360 {
                    rollDegreesModified = 360 - rotationDegrees
                } else {
                    rollDegreesModified = rotationDegrees
                }

                self.pitch = pitchDegrees * .pi / 180.0
                self.roll = rollDegreesModified * .pi / 180.0

//                self.pitch = motionData.attitude.pitch
//
//                let roll = motionData.attitude.roll + motionData.attitude.yaw
//
//                if abs(roll) > deg2rad(180) {
//                    print("top")
//                    self.roll = deg2rad(360) - abs(motionData.attitude.roll + motionData.attitude.yaw)
//                } else {
//                    print("bottom")
//                    self.roll = motionData.attitude.roll + motionData.attitude.yaw
//                }
//
//                self.roll = roll

//                print("---")
//                print("attitude: \(motionData.attitude)")
                ////                print("motion: pitch: \(motionData.attitude.pitch), roll: \(motionData.attitude.roll), yaw: \(motionData.attitude.yaw)")
//                print("output: pitch: \(self.pitch), roll: \(self.roll)")
//                print("---")
            }
        }
    }
}

private func deg2rad(_ number: Double) -> Double {
    number * .pi / 180
}

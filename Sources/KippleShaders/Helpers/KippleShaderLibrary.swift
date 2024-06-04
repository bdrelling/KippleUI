// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(Metal)

import Metal
import MetalPerformanceShaders

final class KippleShaderLibrary {
//    // MARK: Properties
//
//    private var device: MTLDevice? {
//        MTLCreateSystemDefaultDevice()
//    }
//
//    // Whether or not Metal Performance Shaders are supported.
//    private var isMetalSupported: Bool {
//        MPSSupportsMTLDevice(self.device)
//    }
//
//    // MARK: Methods
//
//    func initialize() throws {
//        // Ensure we can get a default device.
//        guard let device else {
//            assertionFailure("Unable to create system default Metal device")
//            return
//        }
//
//        // Ensure the environment supports Metal Performance Shaders.
//        guard self.isMetalSupported else {
//            assertionFailure("Metal Performance Shaders are not supported")
//            return
//        }
//
//        // Create the command queue.
//        let _ = device.makeCommandQueue()
//
//        // Create the default library.
//        let _ = try device.makeDefaultLibrary(bundle: Bundle.kippleShaders)
//    }
}

#endif

// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(Metal)

@testable import KippleShaders
import Metal
import MetalPerformanceShaders
import XCTest

/// Drop-in tests for ensuring Metal resources are found within the tested module.
final class MetalPerformanceShadersTests: XCTestCase {
    // MARK: Properties

    let bundle: Bundle = .kippleShaders

    // MARK: Tests

    /// Tests that the Bundle contains a `default.metallib` file, which is required to initialize the default library.
    func testMetalResourcesExist() {
        let path = self.bundle.path(forResource: "default", ofType: "metallib")
        XCTAssertNotNil(path)
    }

    /// Tests that the default device and default library can be created.
    func testMetalInitialization() throws {
        let device = try XCTUnwrap(MTLCreateSystemDefaultDevice(), "Unable to create default Metal device")
        XCTAssertTrue(MPSSupportsMTLDevice(device), "Device does not support Metal Performance Shaders")
        let _ = try XCTUnwrap(device.makeCommandQueue(), "Unable to create Metal command queue.")
        let _ = try device.makeDefaultLibrary(bundle: self.bundle)
    }
}

#endif

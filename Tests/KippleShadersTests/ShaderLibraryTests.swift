@testable import KippleShaders
import XCTest

final class ShaderLibraryTests: XCTestCase {
    // MARK: Properties
    
    let bundle: Bundle = .kippleShaders
    
    // MARK: Tests

    func testInitialization() throws {
        try KippleShaderLibrary().initialize()
    }
}

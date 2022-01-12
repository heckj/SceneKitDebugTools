import Combine
import SceneKit
@testable import SceneKitDebugTools // @testable for the transforms inclusion, which are internal
import simd // needed for matrix_identity_float4x4
import XCTest

final class SceneKitDebugToolsTests: XCTestCase {
    func testObservableNodeCreation() throws {
        let bareNode = SCNNode()
        let wrapped = ObservableSCNNode(bareNode)
        XCTAssertNotNil(wrapped)
    }

    func testObservableNodeUpdates() throws {
        let bareNode = SCNNode()
        let wrapped = ObservableSCNNode(bareNode)

        let expectation = XCTestExpectation(description: debugDescription)
        let q = DispatchQueue(label: debugDescription)
        var countOfHits = 0

        let cancellable1 = wrapped.objectWillChange
            .sink { _ in
                countOfHits += 1
            }

        XCTAssertEqual(countOfHits, 0)
        q.asyncAfter(deadline: .now() + 0.5) {
            let over2Transform = translationTransform(x: 2, y: 0, z: 0)
            bareNode.simdTransform = matrix_multiply(matrix_identity_float4x4, over2Transform)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(countOfHits, 2)
        XCTAssertNotNil(cancellable1)
    }
}

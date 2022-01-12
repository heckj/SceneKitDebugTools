//
//  DebugSceneView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import SwiftUI

public struct DebugSceneView: View {
    let scene: SCNScene
    let node: SCNNode?

    public var body: some View {
        HStack {
            VStack {
                SceneInfoView(scene: scene)
                OptionalNodeInfoView(node: node)
            }
            SceneView(
                scene: scene,
                options: [.allowsCameraControl, .autoenablesDefaultLighting]
            )
        }
    }

    public init(scene: SCNScene, node: SCNNode?) {
        self.scene = scene
        self.node = node
    }
}

struct DebugSceneView_Previews: PreviewProvider {
    static func generateExampleScene() -> SCNScene {
        let scene = SCNScene()
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.name = "camera"
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        cameraNode.simdLook(at: simd_float3(x: 0, y: 0, z: 0))

        // set up debug/sizing flooring
        scene.rootNode.addChildNode(debugFlooring())
        scene.rootNode.addChildNode(headingIndicator())

        return scene
    }

    static var previews: some View {
        DebugSceneView(scene: generateExampleScene(), node: nil)
    }
}

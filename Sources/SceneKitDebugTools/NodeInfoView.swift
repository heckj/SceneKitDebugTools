//
//  NodeInfoView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import SwiftUI

/// A view that displays a summary of the rotation and positional properties of a SceneKit node.
public struct NodeInfoView: View {
    @ObservedObject var node: ObservableSCNNode

    public var body: some View {
        VStack {
            Text("Name: \(node.wrappedNode.name ?? ""), children: \(node.wrappedNode.childNodes.count)")

            Text("Position").bold()
            Simd3View(simdValue: node.wrappedNode.simdPosition)

            HStack {
                VStack {
                    Text("Rotation").bold()
                    Simd4View(simdValue: node.wrappedNode.simdRotation)
                }
                VStack {
                    Text("pivot").bold()
                    Simd4x4View(simdValue: node.wrappedNode.simdPivot)
                }
            }
            HStack {
                EulerAngleView(eulerAngles: node.wrappedNode.simdEulerAngles)
            }

            Text("Orientation").bold()
            QuaternionView(quat: node.wrappedNode.simdOrientation)

            Text("Transform").bold()
            Simd4x4View(simdValue: node.wrappedNode.simdTransform)
        }
    }

    public init(node: SCNNode) {
        self.node = ObservableSCNNode(node)
    }
}

struct NodeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NodeInfoView(node: SCNNode())
    }
}

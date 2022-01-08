//
//  SceneInfoView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SwiftUI
import SceneKit

struct NodeInfoView: View {
    let node: SCNNode
    var body: some View {
        VStack {
            Text("Name: \(node.name ?? ""), children: \(node.childNodes.count)")
            Text("\(node.debugDescription)")
            
            Text("Position").bold()
            Simd3View(simdValue: node.simdPosition)
            
            Text("Rotation").bold()
            HStack {
                Simd4View(simdValue: node.simdRotation)
                EulerAngleView(eulerAngles: node.simdEulerAngles)
                VStack {
                    Text("pivot").bold()
                    Simd4x4View(simdValue: node.simdPivot)
                }
            }
            Text("Orientation").bold()
            QuaternionView(quat: node.simdOrientation)
            
            Text("Transform").bold()
            Simd4x4View(simdValue: node.simdTransform)
        }
    }
}

struct NodeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NodeInfoView(node: SCNNode())
    }
}

//
//  SceneInfoView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import SwiftUI

public struct OptionalNodeInfoView: View {
    let node: SCNNode?
    public var body: some View {
        if let node = node {
            NodeInfoView(node: node)
        } else {
            Text("No node selected.")
        }
    }

    public init(node: SCNNode?) {
        self.node = node
    }
}

struct OptionalNodeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OptionalNodeInfoView(node: SCNNode())
            OptionalNodeInfoView(node: nil)
        }
    }
}

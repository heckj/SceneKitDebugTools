//
//  SceneInfoView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import SwiftUI

/// A view that displays a summary of the rotation and positional properties of a scenekit node if provided; otherwise, a default view.
public struct OptionalNodeInfoView: View {
    let node: SCNNode?
    public var body: some View {
        if let node = node {
            NodeInfoView(node: node)
                .frame(minWidth: 230, maxWidth: 300)
        } else {
            Text("No node selected.")
                .frame(minWidth: 230, maxWidth: 300)
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

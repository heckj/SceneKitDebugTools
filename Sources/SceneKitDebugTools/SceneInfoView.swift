//
//  SceneInfoView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import SwiftUI

/// A view that displays the summary properties for a SceneKit scene.
public struct SceneInfoView: View {
    let scene: SCNScene

    public var body: some View {
        VStack {
            Text("\(scene.debugDescription)")
            Text("Paused: \(scene.isPaused ? "Yes" : "No")")
        }
    }

    public init(scene: SCNScene) {
        self.scene = scene
    }
}

struct SceneInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SceneInfoView(scene: SCNScene())
    }
}

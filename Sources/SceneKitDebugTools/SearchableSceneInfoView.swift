//
//  SearchableSceneInfoView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import SwiftUI

/// Provides a searchable view that supports displaying nodes from within a SceneKit scene you provide.
///
/// The person using the view can search for SceneKit nodes by name.
/// If found it will be temporarily highlighted in the scene, and the information about the node displayed below the search area.
public struct SearchableSceneInfoView: View {
    let scene: SCNScene
    @State private var node: SCNNode
    @State private var searchText: String = ""
    @FocusState private var searchFieldIsFocused: Bool

    public var body: some View {
        VStack {
            Text("\(scene.debugDescription)")
            Text("Paused: \(scene.isPaused ? "Yes" : "No")")
            HStack {
                Text("Find node:")
                TextField("", text: $searchText)
                    .focused($searchFieldIsFocused)
                #if os(iOS)
                    .textInputAutocapitalization(.never)
                #endif
                    .disableAutocorrection(true)
                    .onSubmit {
                        if let possibleNode = scene.rootNode.childNode(withName: searchText, recursively: true) {
                            self.node = possibleNode
                        } else {
                            self.node = scene.rootNode
                        }
                    }
            }
            Button {
                if let material = node.geometry?.firstMaterial {
                    SCNTransaction.begin()
                    // on completion, remove the highlight
                    SCNTransaction.completionBlock = {
                        SCNTransaction.begin()
                        SCNTransaction.animationDuration = 0.5
                        #if os(OSX)
                            material.emission.contents = NSColor.black
                        #elseif os(iOS)
                            material.emission.contents = UIColor.black
                        #endif
                        SCNTransaction.commit()
                    }
                    // and when we start, highlight with red
                    SCNTransaction.animationDuration = 0.5
                    #if os(OSX)
                        material.emission.contents = NSColor.red
                    #elseif os(iOS)
                        material.emission.contents = UIColor.red
                    #endif
                    SCNTransaction.commit()
                }
            } label: {
                Text("Highlight")
                    .foregroundColor(.primary)
                #if os(iOS)
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                    .background(RoundedRectangle(cornerRadius: 8))
                #endif
            }
            NodeInfoView(node: node)
        }
    }

    /// Creates a new searchable scene view.
    /// - Parameter scene: The scene to search and update when nodes are found.
    public init(scene: SCNScene) {
        self.scene = scene
        node = scene.rootNode
    }
}

struct SearchableSceneInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableSceneInfoView(scene: SCNScene())
    }
}

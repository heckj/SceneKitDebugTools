//
//  SceneInfoView.swift
//  
//
//  Created by Joseph Heck on 1/8/22.
//

import SwiftUI
import SceneKit

struct SceneInfoView: View {
    let scene: SCNScene
    @State private var node: SCNNode
    @State private var searchText: String = ""
    @FocusState private var searchFieldIsFocused: Bool
    
    var body: some View {
        VStack {
            Text("\(scene.debugDescription)")
            Text("Paused: \(scene.isPaused ? "Yes" : "No")")
            HStack {
                Text("Find node:")
                TextField("", text: $searchText)
                    .focused($searchFieldIsFocused)
                    .disableAutocorrection(true)
                    .onSubmit {
                        if let possibleNode = scene.rootNode.childNode(withName: searchText, recursively: true) {
                            self.node = possibleNode
                        } else {
                            self.node = scene.rootNode
                        }
                        
                    }
            }
            NodeInfoView(node: node)
        }
    }
    
    public init(scene: SCNScene) {
        self.scene = scene
        self.node = scene.rootNode
    }
}

struct SceneInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SceneInfoView(scene: SCNScene())
    }
}

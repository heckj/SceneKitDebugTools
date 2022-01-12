//
//  ObservableSCNNode.swift
//  
//
//  Created by Joseph Heck on 1/12/22.
//

import Foundation
import Combine
import SceneKit

public class ObservableSCNNode: ObservableObject {
    @Published var wrappedNode: SCNNode
    private var kvoWatcher: Cancellable?
    public var objectWillChange = Combine.ObservableObjectPublisher()
    
    public init(_ node: SCNNode) {
        wrappedNode = node
        kvoWatcher = wrappedNode.publisher(for: \.simdTransform).sink { _ in
            self.objectWillChange.send()
        }
    }
}

//
//  ObservableSCNNode.swift
//
//
//  Created by Joseph Heck on 1/12/22.
//

import Combine
import Foundation
import SceneKit

/// A class that wraps a SceneKit node to provide an observable object.
///
/// The observable object triggers updates when the node's transform changes, or when the node is changed..
public class ObservableSCNNode: ObservableObject {
    @Published var wrappedNode: SCNNode
    private var kvoWatcher: Cancellable?
    public var objectWillChange = Combine.ObservableObjectPublisher()

    public init(_ node: SCNNode) {
        wrappedNode = node

        // NOTE(heckj): don't KVO wrap the .simdTransform property, as there's some
        // wacky stuff happening in the depths of SceneKit and how it's making that
        // available that results in an exception being thrown:
        // [NSInvocation getArgument:atIndex:]: struct with unknown contents found while getting argument at index -1 (NSInvalidArgumentException)
        kvoWatcher = wrappedNode.publisher(for: \.transform).sink(receiveValue: { _ in
            self.objectWillChange.send()
        })
    }
}

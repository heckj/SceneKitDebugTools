//
//  SceneKitHelpers.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import simd
import SwiftUI

func degreesToRadians(_ value: Double) -> Float {
    Float(value * .pi / 180.0)
}

func degrees(radians: Float) -> Float {
    radians / .pi * 180.0
}

func material(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> SCNMaterial {
    let material = SCNMaterial()
    material.diffuse.contents = CGColor(red: red, green: green, blue: blue, alpha: alpha)
    return material
}

extension SCNVector3 {
    /// The simd_float3 representation that corresponds to this vector.
    var simd_float3: simd_float3 {
        simd.simd_float3(x: Float(x), y: Float(y), z: Float(z))
    }
}

func directionalFin(material: SCNMaterial) -> SCNNode {
    let positions: [SCNVector3] = [
        SCNVector3(x: 0.05, y: 0, z: 0),
        SCNVector3(x: -0.05, y: 0, z: 0),
        SCNVector3(x: 0, y: 1, z: 0),
        SCNVector3(x: 0, y: 0, z: 0.5),
    ]
    let indices: [[UInt32]] = [
        [2, 1, 0],
        [2, 1, 0],
        [2, 1, 0],
        [3, 2, 0],
        [3, 2, 0],
        [3, 2, 0],
        [3, 1, 2],
        [3, 1, 2],
        [3, 1, 2],
        [1, 3, 0],
        [1, 3, 0],
        [1, 3, 0],
    ]

    // compute the normals based on the cross-product of the
    // vertices in the triangle.
    var normals: [SCNVector3] = []
    for indexset in indices {
        let a = positions[Int(indexset[0])].simd_float3
        let b = positions[Int(indexset[1])].simd_float3
        let c = positions[Int(indexset[2])].simd_float3
        let normal = SCNVector3(simd.normalize(simd.cross(a - c, b - c)))
        normals.append(normal)
        normals.append(normal)
        normals.append(normal)
    }
    let sources = [
        SCNGeometrySource(vertices: positions),
        SCNGeometrySource(normals: normals),
    ]
    let g = SCNGeometry(sources: sources,
                        elements: indices.map { indices in
                            SCNGeometryElement(indices: indices, primitiveType: .triangles)
                        })
    g.materials = [material]

    return SCNNode(geometry: g)
}

/// A type that provides a collection of nodes for SceneKit.
///
/// ## Topics
///
/// ### Scale Indicators
///
/// - ``debugFlooring(grid:)``
///
/// ### Directional Indicators
/// 
/// - ``headingIndicator()``
/// - ``axis(length:labels:)``

public enum DebugNodes {
    /// Returns a SceneKit node that provides a visual plane, axis references, and an optional grid to display scale.
    /// - Parameter grid: A Boolean value that indicates whether to display the grid.
    ///
    /// ![A screenshot of the debug flooring with the grid enabled.](debug_flooring.png)
    public static func debugFlooring(grid: Bool = true) -> SCNNode {
        let flooring = SCNNode(geometry: SCNPlane(width: 10, height: 10))
        flooring.geometry?.materials = [material(red: 0.1, green: 0.7, blue: 0.1, alpha: 0.5)]
        flooring.simdEulerAngles = simd_float3(x: degreesToRadians(-90), y: 0, z: 0)

        let axisMaterials = [material(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)]

        let dot3D = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
        dot3D.materials = axisMaterials

        if grid {
            let loc: [Float] = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
            for i in loc {
                for j in loc {
                    let dot = SCNNode(geometry: dot3D)
                    dot.simdPosition = simd_float3(x: Float(i), y: Float(j), z: 0)
                    flooring.addChildNode(dot)
                }
            }
        }
        return flooring
    }

    /// Returns a SceneKit node that provides a visual plane, axis references, and an optional grid to display scale.
    /// - Parameter grid: A Boolean value that indicates whether to display the grid.
    /// - Parameter length: The length of the axis lines.
    /// - Parameter labels: A Boolean value that indicates whether to display the labels.
    /// - Returns: An SCNNode that displays the coordinate axis at the origin point.
    ///
    /// ![A screenshot of the axis indicator](axis.png)
    public static func axis(length: Int = 10, labels: Bool = true) -> SCNNode {
        let baseNode = SCNNode()

        let axisMaterials = [material(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)]
        let lowresCyl = SCNCylinder(radius: 0.01, height: CGFloat(length))
        lowresCyl.radialSegmentCount = 8
        lowresCyl.heightSegmentCount = 1
        lowresCyl.materials = axisMaterials

        let zaxis = SCNNode(geometry: lowresCyl)
        baseNode.addChildNode(zaxis)

        let xaxis = SCNNode(geometry: lowresCyl)
        xaxis.simdEulerAngles = simd_float3(x: 0, y: 0, z: degreesToRadians(90))
        baseNode.addChildNode(xaxis)

        let yaxis = SCNNode(geometry: lowresCyl)
        yaxis.simdEulerAngles = simd_float3(x: degreesToRadians(90), y: 0, z: 0)
        baseNode.addChildNode(yaxis)

        if labels {
            let scaleDown: Float = 0.01

            let plusX = SCNNode(geometry: SCNText(string: "+X", extrusionDepth: 1.0))
            plusX.geometry?.materials = axisMaterials
            plusX.simdScale = simd_float3(scaleDown, scaleDown, scaleDown)
            let maxSizePlusX = Float(max(plusX.boundingBox.max.x - plusX.boundingBox.min.x,
                                         plusX.boundingBox.max.y - plusX.boundingBox.min.y,
                                         plusX.boundingBox.max.z - plusX.boundingBox.min.z)) * scaleDown
            plusX.simdPosition = simd_float3(x: Float(length / 2) - maxSizePlusX, y: 0, z: 0)
            baseNode.addChildNode(plusX)

            let minusX = SCNNode(geometry: SCNText(string: "-X", extrusionDepth: 1.0))
            minusX.geometry?.materials = axisMaterials
            minusX.simdScale = simd_float3(scaleDown, scaleDown, scaleDown)
            let maxSizeMinusX = Float(max(minusX.boundingBox.max.x - minusX.boundingBox.min.x,
                                          minusX.boundingBox.max.y - minusX.boundingBox.min.y,
                                          minusX.boundingBox.max.z - minusX.boundingBox.min.z)) * scaleDown
            minusX.simdPosition = simd_float3(x: Float(length / 2) + maxSizeMinusX, y: 0, z: 0)
            minusX.simdPosition = simd_float3(x: Float(-length / 2), y: 0, z: 0)
            baseNode.addChildNode(minusX)

            let plusY = SCNNode(geometry: SCNText(string: "+Y", extrusionDepth: 1.0))
            plusY.geometry?.materials = axisMaterials
            plusY.simdScale = simd_float3(scaleDown, scaleDown, scaleDown)
            plusY.simdPosition = simd_float3(x: 0, y: Float(length / 2), z: 0)
            baseNode.addChildNode(plusY)

            let minusY = SCNNode(geometry: SCNText(string: "-Y", extrusionDepth: 1.0))
            minusY.geometry?.materials = axisMaterials
            minusY.simdScale = simd_float3(scaleDown, scaleDown, scaleDown)
            minusY.simdPosition = simd_float3(x: 0, y: Float(-length / 2), z: 0)
            baseNode.addChildNode(minusY)

            let plusZ = SCNNode(geometry: SCNText(string: "+Z", extrusionDepth: 1.0))
            plusZ.geometry?.materials = axisMaterials
            plusZ.simdScale = simd_float3(scaleDown, scaleDown, scaleDown)
            plusZ.simdPosition = simd_float3(x: 0, y: 0, z: Float(length / 2))
            baseNode.addChildNode(plusZ)

            let minusZ = SCNNode(geometry: SCNText(string: "-Z", extrusionDepth: 1.0))
            minusZ.geometry?.materials = axisMaterials
            minusZ.simdScale = simd_float3(scaleDown, scaleDown, scaleDown)
            minusZ.simdPosition = simd_float3(x: 0, y: 0, z: Float(-length / 2))
            baseNode.addChildNode(minusZ)
        }

        return baseNode
    }

    /// Returns a SceneKit node that provides a heading indicator.
    ///
    /// ![A screenshot of the directional heading indicator](heading_indicator.png)
    public static func headingIndicator() -> SCNNode {
        let redRingGeometry = SCNTorus(ringRadius: 0.5, pipeRadius: 0.01)
        redRingGeometry.ringSegmentCount = 36
        redRingGeometry.pipeSegmentCount = 8
        redRingGeometry.materials = [material(red: 1.0, green: 0.1, blue: 0.1, alpha: 1)]

        let blueRingGeometry = SCNTorus(ringRadius: 0.5, pipeRadius: 0.01)
        blueRingGeometry.ringSegmentCount = 36
        blueRingGeometry.pipeSegmentCount = 8
        blueRingGeometry.materials = [material(red: 0.1, green: 0.1, blue: 1.0, alpha: 1)]

        let greenRingGeometry = SCNTorus(ringRadius: 0.5, pipeRadius: 0.01)
        greenRingGeometry.ringSegmentCount = 36
        greenRingGeometry.pipeSegmentCount = 8
        greenRingGeometry.materials = [material(red: 0.1, green: 1, blue: 0.1, alpha: 1)]

        let lowresCyl = SCNCylinder(radius: 0.02, height: 0.5)
        lowresCyl.radialSegmentCount = 8
        lowresCyl.heightSegmentCount = 1
        lowresCyl.materials = [material(red: 1.0, green: 0.1, blue: 0.1, alpha: 1)]

        let crosshairCyl = SCNCylinder(radius: 0.02, height: 1)
        crosshairCyl.radialSegmentCount = 8
        crosshairCyl.heightSegmentCount = 1
        crosshairCyl.materials = [material(red: 0, green: 0, blue: 0, alpha: 1)]

        let basering = SCNNode(geometry: greenRingGeometry)
        basering.name = "headingIndicator"
        // green = torus in direction around Y axis - aligned with green heading indicator, affected by yaw

        let ring2 = SCNNode(geometry: redRingGeometry)
        let ring2rotationTransform = rotationAroundXAxisTransform(angle: Angle(degrees: 90))
        ring2.simdTransform = matrix_multiply(matrix_identity_float4x4, ring2rotationTransform)
        // red = torus in direction around X axis - affected by pitch

        let ring3 = SCNNode(geometry: blueRingGeometry)
        let ring3rotationTransform = rotationAroundZAxisTransform(angle: Angle(degrees: 90))
        ring3.simdTransform = matrix_multiply(matrix_identity_float4x4, ring3rotationTransform)
        // blue = torus in direction around Z axis - affected by roll
        basering.addChildNode(ring2)
        basering.addChildNode(ring3)

        let directionCone = SCNNode(geometry: SCNCone(topRadius: 0.0, bottomRadius: 0.25, height: 0.5))
        directionCone.geometry?.materials = [material(red: 0.1, green: 1.0, blue: 0.1, alpha: 1)]
        directionCone.simdPosition = simd_float3(x: 0, y: 0.25, z: 0)
        basering.addChildNode(directionCone)

        let crosshair1 = SCNNode(geometry: crosshairCyl)
        crosshair1.simdTransform = matrix_multiply(matrix_identity_float4x4, rotationAroundXAxisTransform(angle: Angle(degrees: 90)))
        crosshair1.simdPosition = simd_float3(x: 0, y: 0.05, z: 0)
        basering.addChildNode(crosshair1)

        let crosshair2 = SCNNode(geometry: crosshairCyl)
        crosshair2.simdTransform = matrix_multiply(matrix_identity_float4x4, rotationAroundZAxisTransform(angle: Angle(degrees: 90)))
        crosshair2.simdPosition = simd_float3(x: 0, y: 0.05, z: 0)
        basering.addChildNode(crosshair2)

        basering.addChildNode(directionalFin(material: material(red: 1.0, green: 0, blue: 0, alpha: 1.0)))
        return basering
    }
}

struct LocalSceneView_Previews: PreviewProvider {
    static func generateExampleScene() -> (SCNScene, SCNNode) {
        let scene = SCNScene()
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.name = "camera"
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 5, y: 4, z: 7)
        cameraNode.simdLook(at: simd_float3(x: 0, y: 0, z: 0))

        // set up debug/sizing flooring
        scene.rootNode.addChildNode(DebugNodes.debugFlooring(grid: true))
        scene.rootNode.addChildNode(DebugNodes.axis(length: 5, labels: true))

        let headingIndicator = DebugNodes.headingIndicator()
        scene.rootNode.addChildNode(headingIndicator)

        return (scene, headingIndicator)
    }

    public struct TestPiecesView: View {
        let scene: SCNScene
        let headingIndicator: SCNNode
        @State private var angle: String = ""
        @State private var angleValue: Float = 0
        @State private var axis: simd_float3 = .init(x: 0, y: 0, z: 0)
        public var body: some View {
            VStack {
                HStack {
                    Button("X") {
                        axis = simd_float3(x: 1, y: 0, z: 0)
                    }
                    Button("Y") {
                        axis = simd_float3(x: 0, y: 1, z: 0)
                    }
                    Button("Z") {
                        axis = simd_float3(x: 0, y: 0, z: 1)
                    }
                    Button("XZ") {
                        // IMPORTANT: Normalize the axis!!! Otherwise it starts to distort as it rotates...
                        axis = simd_normalize(simd_float3(x: 1, y: 0, z: 1))
                    }
                    Text("angle: \(angleValue.formatted(.number.precision(.significantDigits(2))))")
                    TextField("radians", text: $angle)
                        .onSubmit {
                            if let someValue = Float(angle) {
                                angleValue = someValue
                                SCNTransaction.begin()
                                SCNTransaction.animationDuration = 0.4
                                headingIndicator.simdOrientation = simd_quatf(angle: angleValue, axis: axis)
                                SCNTransaction.commit()
                            }
                        }
                }
                SceneView(
                    scene: scene,
                    options: [.allowsCameraControl, .autoenablesDefaultLighting]
                )
            }
        }

        public init(sceneSet: (SCNScene, SCNNode)) {
            scene = sceneSet.0
            headingIndicator = sceneSet.1
        }
    }

    static var previews: some View {
        TestPiecesView(sceneSet: generateExampleScene())
    }
}

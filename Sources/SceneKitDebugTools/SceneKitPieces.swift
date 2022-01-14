//
//  SceneKitHelpers.swift
//  X5336
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
    var simd_float3: simd_float3 {
        simd.simd_float3(x: Float(x), y: Float(y), z: Float(z))
    }
}

public func directionalFin(material: SCNMaterial) -> SCNNode {
    let positions: [SCNVector3] = [
        SCNVector3(x: 0.05, y: 0, z: 0),
        SCNVector3(x: -0.05, y: 0, z: 0),
        SCNVector3(x: 0, y: 1, z: 0),
        SCNVector3(x: 0, y: 0, z: 0.5),
    ]
    let indices: [[UInt32]] = [
        [2, 1, 0],
        [3, 2, 0],
        [3, 1, 2],
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
    }
    // NOTE(heckj): It's visible, but I suspect I'm not setting the correct
    // normals for the vertices. I may have some clock-wise/counter-clockwise
    // issues and directional normals screwed up here.
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

/// Returns a SceneKit node that provides a visual plane, axis references, and an optional grid to display scale.
/// - Parameter grid: A Boolean value that indicates whether to display the grid.
public func debugFlooring(grid: Bool = true) -> SCNNode {
    let flooring = SCNNode(geometry: SCNPlane(width: 10, height: 10))
    flooring.geometry?.materials = [material(red: 0.1, green: 0.7, blue: 0.1, alpha: 0.5)]
    flooring.simdEulerAngles = simd_float3(x: degreesToRadians(-90), y: 0, z: 0)

    let axisMaterials = [material(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)]

    let dot3D = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
    dot3D.materials = axisMaterials

    let lowresCyl = SCNCylinder(radius: 0.01, height: 10)
    lowresCyl.radialSegmentCount = 8
    lowresCyl.heightSegmentCount = 1
    lowresCyl.materials = axisMaterials

    let zaxis = SCNNode(geometry: lowresCyl)
    flooring.addChildNode(zaxis)
    let xaxis = SCNNode(geometry: lowresCyl)
    xaxis.simdEulerAngles = simd_float3(x: 0, y: 0, z: degreesToRadians(90))
    flooring.addChildNode(xaxis)
    let yaxis = SCNNode(geometry: lowresCyl)
    yaxis.simdEulerAngles = simd_float3(x: degreesToRadians(90), y: 0, z: 0)
    flooring.addChildNode(yaxis)

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

/// Returns a SceneKit node that provides a heading indicator.
public func headingIndicator() -> SCNNode {
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

struct LocalSceneView_Previews: PreviewProvider {
    static func generateExampleScene() -> SCNScene {
        let scene = SCNScene()
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.name = "camera"
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: -1.5, y: 1, z: 3)
        cameraNode.simdLook(at: simd_float3(x: 0, y: 0, z: 0))

        // set up debug/sizing flooring
        scene.rootNode.addChildNode(debugFlooring())
        scene.rootNode.addChildNode(headingIndicator())

        return scene
    }

    static var previews: some View {
        SceneView(
            scene: generateExampleScene(),
            options: [.allowsCameraControl, .autoenablesDefaultLighting]
        )
    }
}

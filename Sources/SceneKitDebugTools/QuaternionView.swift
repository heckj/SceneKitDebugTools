//
//  QuaternionView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import simd
import SwiftUI

/// A view that displays the set of values for a quaternion rotation.
public struct QuaternionView: View {
    let quat: simd_quatf
    public var body: some View {
        VStack {
            Simd4View(simdValue: quat.vector)
            HStack {
                Text("Angle:")
                AngleView(angle: Angle(radians: Double(quat.angle)))
                Text("Axis:")
                Simd3View(simdValue: quat.axis)
            }
        }
    }

    public init(quat: simd_quatf) {
        self.quat = quat
    }
}

struct QuaternionView_Previews: PreviewProvider {
    static var previews: some View {
        QuaternionView(quat: simd_quatf(angle: Float.pi / 3, axis: simd_float3(1, 0, 0)))
    }
}

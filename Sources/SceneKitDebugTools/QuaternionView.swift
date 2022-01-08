//
//  SwiftUIView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import simd
import SwiftUI

struct QuaternionView: View {
    let quat: simd_quatf
    var body: some View {
        VStack {
//            Text("\(quat.debugDescription)")
            Simd4View(simdValue: quat.vector)
            HStack {
                Text("Angle:")
                AngleView(angle: Angle(radians: Double(quat.angle)))
                Text("Axis:")
                Simd3View(simdValue: quat.axis)
            }
        }
    }
}

struct QuaternionView_Previews: PreviewProvider {
    static var previews: some View {
        QuaternionView(quat: simd_quatf(angle: Float.pi / 3, axis: simd_float3(1, 0, 0)))
    }
}

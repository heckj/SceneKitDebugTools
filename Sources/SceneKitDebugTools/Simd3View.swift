//
//  Simd3View.swift
//
//  Created by Joseph Heck on 1/8/22.
//

import simd
import SwiftUI

struct Simd3View: View {
    let simdValue: simd_float3

    var body: some View {
        HStack {
            Text(simdValue.x, format: .number.precision(
                .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
            Text(simdValue.y, format: .number.precision(
                .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
            Text(simdValue.z, format: .number.precision(
                .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
        }
        .padding(2)
        .border(.blue)
    }
}

struct Simd3View_Previews: PreviewProvider {
    static var previews: some View {
        Simd3View(simdValue: simd_float3(x: 0.1, y: 0, z: Float.pi / 4))
    }
}

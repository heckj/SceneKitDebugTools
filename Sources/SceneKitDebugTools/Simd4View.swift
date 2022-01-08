//
//  Simd3View.swift
//
//  Created by Joseph Heck on 1/8/22.
//

import simd
import SwiftUI

struct Simd4View: View {
    let simdValue: simd_float4

    var body: some View {
        HStack {
            Text(simdValue.x, format: .number.precision(
                .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
            Text(simdValue.y, format: .number.precision(
                .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
            Text(simdValue.z, format: .number.precision(
                .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
            Text(simdValue.w, format: .number.precision(
                .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
        }
        .padding(2)
        .border(.blue)
    }
}

struct Simd4View_Previews: PreviewProvider {
    static var previews: some View {
        Simd4View(simdValue: simd_float4(x: 0.1, y: 0, z: Float.pi / 4, w: 0.707))
    }
}

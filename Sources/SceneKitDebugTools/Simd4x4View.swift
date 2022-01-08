//
//  Simd3View.swift
//
//  Created by Joseph Heck on 1/8/22.
//

import SwiftUI
import simd

struct Simd4x4View: View {
    let simdValue: simd_float4x4
    var body: some View {
        HStack {
            VStack {
                Text(simdValue.columns.0.x,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.0.y,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.0.z,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.0.w,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
            }
            VStack {
                Text(simdValue.columns.1.x,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.1.y,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.1.z,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.1.w,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
            }
            VStack {
                Text(simdValue.columns.2.x,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.2.y,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.2.z,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.2.w,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
            }
            VStack {
                Text(simdValue.columns.3.x,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.3.y,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.3.z,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
                Text(simdValue.columns.3.w,
                     format: .number.precision(
                        .integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3)))
            }
        }
        .padding(2)
        .border(.blue)
    }
}

struct Simd4x4View_Previews: PreviewProvider {
    static let example4x4 = simd_float4x4(simd_quatf(angle: Float.pi/3, axis: simd_float3(1,1,0)))
    static var previews: some View {
        Simd4x4View(simdValue: example4x4)
    }
}

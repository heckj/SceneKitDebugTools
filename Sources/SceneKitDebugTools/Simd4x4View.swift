//
//  Simd4x4View.swift
//
//  Created by Joseph Heck on 1/8/22.
//

import simd
import SwiftUI

/// A view that displays the values for a simd four by four float matrix.
public struct Simd4x4View: View {
    let simdValue: simd_float4x4
    public var body: some View {
        HStack {
            HStack {
                VStack {
                    Text(simdValue.columns.0.x,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.0.y,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.0.z,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.0.w,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                }
                VStack {
                    Text(simdValue.columns.1.x,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.1.y,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.1.z,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.1.w,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                }
                VStack {
                    Text(simdValue.columns.2.x,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.2.y,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.2.z,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.2.w,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                }
                VStack {
                    Text(simdValue.columns.3.x,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.3.y,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.3.z,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                    Text(simdValue.columns.3.w,
                         format: .number.precision(
                             .integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))
                }
            }
            .padding(2)
            .border(.blue)

            Button {
                writeStringToPasteboard(simdValue.codetext)
            } label: {
                Image(systemName: "doc.on.clipboard")
            }
        }
    }

    public init(simdValue: simd_float4x4) {
        self.simdValue = simdValue
    }
}

struct Simd4x4View_Previews: PreviewProvider {
    static let rotation4x4 = simd_float4x4(simd_quatf(angle: Float.pi / 3, axis: simd_float3(1, 1, 0)))
    static let shifted4x4 = matrix_multiply(matrix_identity_float4x4, translationTransform(x: 0, y: 2, z: -2))
    static let move_then_rotate = matrix_multiply(shifted4x4, rotation4x4)
    static let rotate_then_move = matrix_multiply(rotation4x4, shifted4x4)
    static var previews: some View {
        VStack {
            Simd4x4View(simdValue: rotation4x4)
            Simd4x4View(simdValue: shifted4x4)
            Simd4x4View(simdValue: move_then_rotate)
            Simd4x4View(simdValue: rotate_then_move)
            Text(move_then_rotate.codetext)
        }
    }
}

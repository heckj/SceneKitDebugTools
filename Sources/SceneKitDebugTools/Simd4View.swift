//
//  Simd4View.swift
//
//  Created by Joseph Heck on 1/8/22.
//

import simd
import SwiftUI

/// A view that displays the values for a simd four float vector.
public struct Simd4View: View {
    let simdValue: simd_float4

    public var body: some View {
        HStack {
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

            Button {
                writeStringToPasteboard(simdValue.codetext)
            } label: {
                Image(systemName: "doc.on.clipboard")
            }
        }
    }

    public init(simdValue: simd_float4) {
        self.simdValue = simdValue
    }
}

struct Simd4View_Previews: PreviewProvider {
    static var previews: some View {
        Simd4View(simdValue: simd_float4(x: 0.1, y: 0, z: Float.pi / 4, w: 0.707))
    }
}

//
//  simd_float4x4+codetext.swift
//
//
//  Created by Joseph Heck on 1/18/22.
//

import Foundation
import simd
public extension simd_float4x4 {
    /// A multi-line string that can be copied and pasted into code which recreates the value.
    var codetext: String {
        var result = "simd_float4x4(\n"
        let (c1, c2, c3, c4) = columns
        result += "    simd_float4(\(c1.x), \(c1.y), \(c1.z), \(c1.w)),\n"
        result += "    simd_float4(\(c2.x), \(c2.y), \(c2.z), \(c2.w)),\n"
        result += "    simd_float4(\(c3.x), \(c3.y), \(c3.z), \(c3.w)),\n"
        result += "    simd_float4(\(c4.x), \(c4.y), \(c4.z), \(c4.w))\n"
        result += ")\n"
        return result
    }
}

public extension simd_float3 {
    /// A multi-line string that can be copied and pasted into code which recreates the value.
    var codetext: String {
        "simd_float3(\(x), \(y), \(z))\n"
    }
}

public extension simd_float4 {
    /// A multi-line string that can be copied and pasted into code which recreates the value.
    var codetext: String {
        "simd_float4(\(x), \(y), \(z), \(w)\n"
    }
}

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
        result += "    simd_float4(\(c1.x), \(c2.x), \(c3.x), \(c4.x)),\n"
        result += "    simd_float4(\(c1.y), \(c2.y), \(c3.y), \(c4.y)),\n"
        result += "    simd_float4(\(c1.z), \(c2.z), \(c3.z), \(c4.z)),\n"
        result += "    simd_float4(\(c1.w), \(c2.w), \(c3.w), \(c4.w))\n"
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

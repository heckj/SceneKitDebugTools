//
//  SwiftUIView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SceneKit
import SwiftUI

public struct EulerAngleView: View {
    let eulerAngles: simd_float3
    public var body: some View {
        VStack {
            HStack {
                Text("Pitch")
                AngleView(angle: Angle(radians: Double(eulerAngles.x)))
            }
            HStack {
                Text("Roll")
                AngleView(angle: Angle(radians: Double(eulerAngles.z)))
            }
            HStack {
                Text("Yaw")
                AngleView(angle: Angle(radians: Double(eulerAngles.y)))
            }
        }
    }

    public init(eulerAngles: simd_float3) {
        self.eulerAngles = eulerAngles
    }
}

struct EulerAngleView_Previews: PreviewProvider {
    static var previews: some View {
        EulerAngleView(eulerAngles: simd_float3(0, 0, 0))
    }
}

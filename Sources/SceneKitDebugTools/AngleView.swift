//
//  SwiftUIView.swift
//
//
//  Created by Joseph Heck on 1/8/22.
//

import SwiftUI

/// A view that displays the values for an Angle.
public struct AngleView: View {
    let angle: Angle
    public var body: some View {
        Text(" \(angle.degrees.formatted(.number.notation(.compactName)))° (\(angle.radians.formatted(.number.precision(.integerAndFractionLength(integerLimits: 1 ... 2, fractionLimits: 0 ... 3)))))")
    }

    public init(angle: Angle) {
        self.angle = angle
    }
}

struct AngleView_Previews: PreviewProvider {
    static var previews: some View {
        AngleView(angle: Angle(degrees: 30))
    }
}

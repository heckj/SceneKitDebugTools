//
//  SwiftUIView.swift
//  
//
//  Created by Joseph Heck on 1/8/22.
//

import SwiftUI

struct AngleView: View {
    let angle: Angle
    var body: some View {
        Text("\(angle.radians.formatted(.number.precision(.integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3))))  (\(angle.degrees.formatted(.number.notation(.compactName)))°)")
    }
}

struct AngleView_Previews: PreviewProvider {
    static var previews: some View {
        AngleView(angle: Angle(degrees: 30))
    }
}

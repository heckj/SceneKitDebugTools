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
        VStack {
            Text("\(angle.radians.formatted(.number.precision(.integerAndFractionLength(integerLimits: 1...2, fractionLimits: 0...3))))  (\(angle.degrees.formatted(.number.notation(.compactName)))°)")
        }
        .padding(2)
        .border(.blue)
    }
}

struct AngleView_Previews: PreviewProvider {
    static var previews: some View {
        AngleView(angle: Angle(degrees: 30))
    }
}

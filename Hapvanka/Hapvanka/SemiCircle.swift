//
//  SemiCircle.swift
//  (name)
//
//  Created by Stoyan Nikolov on 16.05.24.
//

import SwiftUI

struct SemiCircle: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.maxY)
        let radius = rect.height
        
        var p = Path()
        p.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        p.addLine(to: center)
        p.closeSubpath()
        
        return p
    }
}

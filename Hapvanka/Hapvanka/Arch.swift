//
//  Arch.swift
//  (name)
//
//  Created by Stoyan Nikolov on 17.05.24.
//

import SwiftUI

struct Arch: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.maxY)
        let radius = rect.height / 2
        
        p.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        p.addLine(to: CGPoint(x:rect.minX, y:rect.minY))
        p.addLine(to: CGPoint(x:rect.maxX, y:rect.minY))
        p.addLine(to: CGPoint(x:rect.maxX, y:rect.maxY))
        p.closeSubpath()
        
        return p
    }
}

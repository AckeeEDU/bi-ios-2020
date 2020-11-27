//
//  CanvasView.swift
//  RealtimeDrawing
//
//  Created by Jan Misar on 27/11/2020.
//

import UIKit

class CanvasView: UIView {
    
    var paths: [DrawingPath] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setLineWidth(2)
        context.setStrokeColor(UIColor.label.cgColor)
        
        for path in paths {
            context.beginPath()
            context.move(to: path.points.first!) // víme jistě, že tam první máme

            context.addLines(between: path.points)
            context.drawPath(using: .stroke)
        }
    }
}

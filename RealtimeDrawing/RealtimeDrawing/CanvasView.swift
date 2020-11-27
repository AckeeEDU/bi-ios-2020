//
//  CanvasView.swift
//  RealtimeDrawing
//
//  Created by Jan Misar on 27/11/2020.
//

import UIKit

class CanvasView: UIView {
    
    var points: [CGPoint] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setLineWidth(2)
        context.setStrokeColor(UIColor.label.cgColor)
        
        context.beginPath()
        
        if let firstPoint = points.first {
            context.move(to: firstPoint)
        }
        context.addLines(between: points)
        
        context.drawPath(using: .stroke)
    }
    
}

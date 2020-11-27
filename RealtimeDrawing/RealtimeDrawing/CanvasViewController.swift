//
//  CanvasViewController.swift
//  RealtimeDrawing
//
//  Created by Jan Misar on 27/11/2020.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    
    weak var currentPath: DrawingPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panChanged(_:)))
        canvasView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func panChanged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: canvasView)
        
        switch gestureRecognizer.state {
        case .began:
            let newPath = DrawingPath()
            newPath.points.append(point)
            canvasView.paths.append(newPath)
            
            currentPath = newPath
        case .changed:
            currentPath?.points.append(point)
        case .cancelled, .ended, .failed:
            currentPath = nil
        default:
            break
        }
        canvasView.setNeedsDisplay()
    }

}


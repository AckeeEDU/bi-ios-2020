//
//  CanvasViewController.swift
//  RealtimeDrawing
//
//  Created by Jan Misar on 27/11/2020.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panChanged(_:)))
        canvasView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func panChanged(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            let point = gestureRecognizer.location(in: canvasView)
            canvasView.points.append(point)
            break
        case .cancelled, .ended, .failed:
            break
        default:
            break
        }
        canvasView.setNeedsDisplay()
    }

}


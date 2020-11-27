//
//  CanvasViewController.swift
//  RealtimeDrawing
//
//  Created by Jan Misar on 27/11/2020.
//

import UIKit
import FirebaseDatabase
import CodableFirebase

class CanvasViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var canvasView: CanvasView!
    
    private var databaseReference: DatabaseReference!
    
    weak var currentPath: DrawingPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawingGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panChanged(_:)))
        drawingGestureRecognizer.maximumNumberOfTouches = 1
        canvasView.addGestureRecognizer(drawingGestureRecognizer)
        
        scrollView.panGestureRecognizer.minimumNumberOfTouches = 2
        scrollView.panGestureRecognizer.require(toFail: drawingGestureRecognizer)
        
        databaseReference = Database.database().reference(withPath: "canvas")
        
        databaseReference.observe(.childAdded) { [weak self] snapshot in
            guard let self = self, let value = snapshot.value else { return }
            
            if let path = try? FirebaseDecoder().decode(DrawingPath.self, from: value) {
                // čára, kterou jsme nakreslili, odešleme na firebase a v zápětí se vrátí v observe bloku -> měli bychom ji v poli 2x!
                if self.canvasView.paths.contains(where: { $0.key == path.key }) {
                    return
                }

                self.canvasView.paths.append(path)
                self.canvasView.setNeedsDisplay()
            }
        }
        
        databaseReference.observe(.childRemoved) { [weak self] snapshot in
            if let index = self?.canvasView.paths.firstIndex(where: { $0.key == snapshot.key }) {
                self?.canvasView.paths.remove(at: index)
            }
            self?.canvasView.setNeedsDisplay()
        }
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
            guard let newPath = currentPath else { return }
            
            let newPathReference = databaseReference.childByAutoId()
            newPath.key = newPathReference.key
            let data = try! FirebaseEncoder().encode(newPath)
            
            newPathReference.setValue(data)
            
            currentPath = nil
        default:
            break
        }
        canvasView.setNeedsDisplay()
    }

}


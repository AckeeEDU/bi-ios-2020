import Foundation
import MapKit

final class PostLocationAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    let title: String?
    
    init(
        coordinate: CLLocationCoordinate2D,
        title: String?
    ) {
        self.coordinate = coordinate
        self.title = title
    }
}


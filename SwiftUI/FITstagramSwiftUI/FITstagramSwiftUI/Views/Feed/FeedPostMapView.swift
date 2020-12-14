//
//  FeedPostMapView.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import SwiftUI
import MapKit

struct FeedPostMapView: View {
    @State private var region: MKCoordinateRegion
    
    let location: Location
    
    init(location: Location) {
        self.location = location
        
        _region = .init(
            initialValue: MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
        )
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [location]) { item in
            MapAnnotation(coordinate: item.coordinate) {
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.accentColor)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(location.name)
    }
}

struct FeedPostMapView_Previews: PreviewProvider {
    static var previews: some View {
        FeedPostMapView(
            location: Location(
                name: Post.preview.location!,
                coordinate: Post.preview.coordinate!
            )
        )
    }
}

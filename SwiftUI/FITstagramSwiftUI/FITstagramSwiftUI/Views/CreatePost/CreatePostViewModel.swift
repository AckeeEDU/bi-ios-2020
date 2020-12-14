//
//  CreateViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import UIKit
import CoreLocation

final class CreatePostViewModel: NSObject, ObservableObject {
    enum State {
        case ready
        case saving
        case finished(success: Bool)
    }
    
    @Published var caption = ""
    @Published var image: UIImage?
    @Published var location: Location?
    
    @Published var state: State = .ready
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        return locationManager
    }()
    
    private var requestLocation = false
    
    private var username: String {
        UserDefaults.standard.string(forKey: "username") ?? "username"
    }
    
    private var currentLocationCoordinate: CLLocationCoordinate2D? = nil
    
    private let networkService: NetworkServicing
    private let locationService: LocationServicing
    
    // MARK: - Initialization
    
    init(
        networkService: NetworkServicing = NetworkService(),
        locationService: LocationServicing = LocationService()
    ) {
        self.networkService = networkService
        self.locationService = locationService
    }
}

// MARK: - Public methods
extension CreatePostViewModel {
    func createPost() {
        state = .saving
        
        var urlRequest = URLRequest(url: URL(string: "https://ackeeedu.000webhostapp.com/api.php/records/posts")!)
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        urlRequest.httpMethod = "POST"
        
        let maxSize = UIScreen.main.bounds.width/UIScreen.main.scale
        let resizedImage = image?.imageResized(to: CGSize(width: maxSize, height: maxSize))
        
        let body: [String: Any?] = [
            "image": resizedImage?.jpegData(compressionQuality: 0.5)?.base64EncodedString(),
            "username": username,
            "caption": caption,
            "lat": location?.coordinate.latitude,
            "lon": location?.coordinate.longitude,
            "location": location?.name
        ]
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: body)
        
        networkService.fetch(urlRequest: urlRequest) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success:
                    self?.state = .finished(success: true)
                case .failure:
                    self?.state = .finished(success: false)
                }
            }
        }
    }
    
    func requestUserLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            requestLocation = true
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("I need location!")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            print("I need location")
        }
    }
    
    func showLocation(_ coordinate: CLLocationCoordinate2D) {
        locationService.closestPlacemark(for: coordinate) { [weak self] in
            guard let placemark = $0 else {
                self?.removeUserLocation()
                
                return
            }
            
            self?.location = Location(
                name: placemark.subLocality ?? "Unknown",
                coordinate: coordinate
            )
        }
    }
    
    func removeUserLocation() {
        location = nil
    }
}

// MARK: - CLLocationManagerDelegate
extension CreatePostViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            break
        case .restricted, .denied:
            print("I need location!")
        case .authorizedAlways, .authorizedWhenInUse:
            guard requestLocation else {
                return
            }
            
            requestLocation = false
            manager.requestLocation()
        @unknown default:
            print("I need location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        showLocation(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

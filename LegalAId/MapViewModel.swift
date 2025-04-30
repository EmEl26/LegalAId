import Foundation
import CoreLocation
import Combine

class MapViewModel: ObservableObject {
    @Published var mappedSupports: [MappedPsychologySupport] = []
    private let geocoder = CLGeocoder()

    func geocode(supports: [PsychologySupport]) {
        for support in supports {
            geocoder.geocodeAddressString(support.address) { placemarks, error in
                if let location = placemarks?.first?.location {
                    let mapped = MappedPsychologySupport(
                        support: support,
                        coordinate: location.coordinate
                    )
                    DispatchQueue.main.async {
                        self.mappedSupports.append(mapped)
                    }
                } else {
                    print("Geocode failed for \(support.address): \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }
}

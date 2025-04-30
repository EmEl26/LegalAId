
import MapKit

struct MappedPsychologySupport: Identifiable {
    let id = UUID()
    let support: PsychologySupport
    let coordinate: CLLocationCoordinate2D
}

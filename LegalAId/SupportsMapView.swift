import SwiftUI
import MapKit

struct SupportsMapView: View {
    @StateObject private var viewModel = MapViewModel()
    let supports: [PsychologySupport]

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.8448, longitude: -73.8648), // Bronx default
            span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
        )
    )

    var body: some View {
            Map(position: $cameraPosition) {
                ForEach(viewModel.mappedSupports) { item in
                    Marker(item.support.organization_name, coordinate: item.coordinate)
                }
            }
            .frame(height: 300)
            .onAppear {
                viewModel.geocode(supports: supports)
            }
        }
    }

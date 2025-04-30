import SwiftUI

struct PsychologySupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var psychologySup: [PsychologySupport] = []

    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }

    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }

    private var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                                .padding(2)
                        }
                        
                        Spacer()
                        
                        Text("Psychology Support")
                            .font(.title)
                            .foregroundColor(primaryColor)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        SupportsMapView(supports: psychologySup)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                        LazyVStack(spacing: 10) {
                            ForEach(psychologySup) { psychologySup in
                                PsychologyCard(psychologyItem: psychologySup, primColor: primaryColor, secColor: secColor)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }
                .background(backgroundColor.ignoresSafeArea())
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    psychologySup = decode_psych("psychology-resources.json")
                }
            }
            
        }
    }
}

#Preview {
    PsychologySupView()
}

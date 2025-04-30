
import SwiftUI

struct SingleLegalView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    let legalRes: LegalResource
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(primaryColor)
                                .padding()
                        }
                        Spacer()
                    }
                    
                    Image("law2")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Text(legalRes.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(primaryColor)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        Text("11/11/11 •")
                        Text("Author:")
                        Text("Legal Eagle")
                    }
                    .foregroundColor(Color(red: 0.674, green: 0.678, blue: 0.725))
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(legalRes.description)
                    .foregroundColor(primaryColor)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(backgroundColor.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
        }
    }

#Preview {
    SingleLegalView(legalRes: LegalResource(title: "Sample Wills", description: "What to do if you are called into questioning.", icon: "exclamationmark.triangle"))
}

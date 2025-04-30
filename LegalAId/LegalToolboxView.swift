import SwiftUI

struct LegalToolboxView: View {
    
    @State var search: String = ""
    
    let groupedQuestions: [(date: String, questions: [String])] = [
        ("Today", [
            "Speeding ticket best practices?",
            "Injury damages?",
            "Is it normal to sue a noisy neighbor?"
        ]),
        ("Yesterday", [
            "Speeding ticket best practices?",
            "Robinhood Foundation",
            "Attorney: Lisa James, $50/hr"
        ]),
        ("2 Weeks Ago", [
            "Speeding ticket best practices?",
            "Injury damages?",
            "Can I represent my own eviction case?"
        ])
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header
            HStack {
                Text("Legal Toolbox")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.2))
                
                Spacer()
                
                HStack(spacing: 20) {
                    Image(systemName: "square.and.pencil")
                }
                .foregroundColor(.gray)
                .font(.title3)
            }
            .padding(.horizontal)
            .padding(.top)
             
            // Search bar
            HStack {
                TextField("Search",
                          text: $search ,
                          prompt: Text("\(Image(systemName: "magnifyingglass")) Search...").foregroundColor(.gray)
                )
                
                Spacer()
                
                Image(systemName: "doc.on.doc")
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
            }
            .padding()
            .background(Color(red: 0.7607843137254902, green: 0.7647058823529411, blue: 0.796078431372549).opacity(0.3))
            .cornerRadius(16)
            .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(groupedQuestions, id: \.date) { group in
                        Text(group.date)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        
                        VStack(spacing: 8) {
                            ForEach(group.questions, id: \.self) { question in
                                Text(question)
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(red: 0.2, green: 0.28, blue: 0.38))
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .background(Color(red: 0.93, green: 0.95, blue: 0.96).ignoresSafeArea())
    }
}

#Preview {
    LegalToolboxView()
}

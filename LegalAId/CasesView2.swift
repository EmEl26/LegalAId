struct CaseSummary: Codable, Identifiable {
    var id: String { docket_number }
    let name: String
    let href: String
    let docket_number: String
    let timeline: [CaseTimeline]
    let term: String
    let description: String?
    let justia_url: String?
}

struct CaseTimeline: Codable {
    let event: String
    let dates: [Int]
    let href: String
}

// Adjusted CaseDetails to include more detailed information
struct CaseDetails: Codable {
    let name: String
    let docket_number: String
    let href: String
    let first_party: String
    let second_party: String
    let timeline: [CaseTimeline]
    let facts_of_the_case: String
    let question: String
    let conclusion: String
}

func fetchCases(term: String? = nil, page: Int = 1, perPage: Int = 10, completion: @escaping ([CaseSummary]) -> Void) {
    let searchTerm = term ?? "2015"
    let urlString = "https://api.oyez.org/cases?per_page=\(perPage)&page=\(page)&filter=term:\(searchTerm)"
    
    guard let url = URL(string: urlString) else {
        DispatchQueue.main.async { completion([]) }
        return
    }
    
    // Create a URLRequest with a timeout interval.
    var request = URLRequest(url: url)
    request.timeoutInterval = 15.0 // Adjust this value as needed.
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle any error immediately.
        if let error = error {
            print("Error fetching cases:", error)
            DispatchQueue.main.async {
                completion([])
            }
            return
        }
        
        guard let data = data else {
            DispatchQueue.main.async { completion([]) }
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let cases = try decoder.decode([CaseSummary].self, from: data)
            DispatchQueue.main.async {
                completion(cases)
            }
        } catch {
            print("Decoding failed for page \(page):", error)
            DispatchQueue.main.async {
                completion([])
            }
        }
    }.resume()
}




func fetchCaseDetails(docketNumber: String, term: Int, completion: @escaping (CaseDetails?) -> Void) {
    // URL for fetching case details
    let urlString = "https://api.oyez.org/cases/\(term)/\(docketNumber)"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else { return }
        
        let decoder = JSONDecoder()
        if let caseDetails = try? decoder.decode(CaseDetails.self, from: data) {
            DispatchQueue.main.async {
                completion(caseDetails)
            }
        }
    }.resume()
}

import SwiftUI

struct CasesView2: View {
    @Environment(\.dismiss) var dismiss
    @State private var cases: [CaseSummary] = []
    @State private var selectedCaseDetails: CaseDetails?
    @State private var selectedCaseSummary: CaseSummary?
    @State private var isLoading = false
    @State private var currentPage = 1
    @State private var selectedTerm: String? = "2015"

    let pageSize = 10
    
    let  primColor =
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    
    let secColor = Color.gray.opacity(0.1)
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        if let caseSummary = selectedCaseSummary, let details = selectedCaseDetails {
            SingleCaseView2(caseSummary: caseSummary, caseDetails: details)
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if isLoading {
                        ProgressView("Loading cases...")
                            .padding()
                            .foregroundColor(primColor)
                    } else {
                        ZStack {
                            HStack {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "arrow.left")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                Spacer()
                            }
                            
                            Text("Cases")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(primColor)
                        }
                        .padding(.horizontal, 7)
                        .padding(.bottom)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(["2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024"], id: \.self) { label in
                                    Button(action: {
                                        selectedTerm = label
                                        currentPage = 1
                                        isLoading = true
                                        fetchCases(term: selectedTerm, page: currentPage, perPage: pageSize) { newCases in
                                            self.cases = newCases
                                            self.isLoading = false
                                        }
                                    }) {
                                        Text(label)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(selectedTerm == label ? secColor : primColor)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        List(cases) { caseItem in
                            CaseCard3(caseItem: caseItem, primColor: primColor, secColor: secColor)
                                .onTapGesture {
                                    selectedCaseSummary = caseItem
                                    isLoading = true
                                    fetchCaseDetails(docketNumber: caseItem.docket_number, term: Int(caseItem.term) ?? 2020) { details in
                                        selectedCaseDetails = details
                                        isLoading = false
                                    }
                                }
                                .listRowSeparator(.hidden)
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                    
                    if !isLoading {
                        Button("Load More Cases") {
                            isLoading = true
                            currentPage += 1
                            fetchCases(term: selectedTerm, page: currentPage, perPage: pageSize) { newCases in
                                self.cases.append(contentsOf: newCases)
                                self.isLoading = false
                            }
                        }
                        .padding()
                    }
                    
                    NavigationLink(
                        destination: destinationView(),
                        isActive: Binding(
                            get: { selectedCaseDetails != nil },
                            set: { if !$0 { selectedCaseDetails = nil } }
                        ),
                        label: { EmptyView() }
                    )
                    .onAppear {
                        isLoading = true
                        fetchCases(term: selectedTerm, page: currentPage, perPage: pageSize) { fetchedCases in
                            self.cases = fetchedCases
                            self.isLoading = false
                        }
                    }
                    
                }
            }
            .background(backgroundColor.ignoresSafeArea())
        }
        .background(backgroundColor.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

    

#Preview {
    CasesView2()
}



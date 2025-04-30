import SwiftUI

struct MainScreen: View {
    
    public var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
     public var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    public var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }
    
    @State private var isLoading = false
    @State private var selectedCaseDetails: CaseDetails?
    @State private var selectedCaseSummary: CaseSummary?
    
    let rows = [GridItem(.flexible())]
    
    @State private var attorneys: [Attorney] = []
    @State private var supportResources: [PsychologySupport] = []
    @State private var caseItems: [CaseSummary] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if isLoading {
                        ProgressView("Loading cases...")
                            .padding()
                            .foregroundColor(primaryColor)
                    } else {
                        headerView
                        
                        caseSection
                        
                        attorneySection
                        
                        psychologySection
                    }
                }
                .padding(.horizontal)
                .background(backgroundColor.ignoresSafeArea())
                .onAppear {
                    loadData()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        Text("Legal Ai(d)")
            .font(.title)
            .foregroundColor(primaryColor)
            .fontWeight(.bold)
            .padding(.horizontal)
    }
    
    // MARK: - Case Section
    private var caseSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Cases")
                .foregroundColor(primaryColor)
                .font(.title2)
                .tracking(1)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 12) {
                    ForEach(caseItems.prefix(5)) { case_ in
                        CaseItemView(case_: case_)
                            .frame(width: 150, height: 180)
                    }
                    
                    SeeMoreButton(destination: AnyView(CasesView2()))
                }
            }
        }
    }
    
    // MARK: - Attorney Section
    private var attorneySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Low Cost Attorneys")
                .foregroundColor(primaryColor)
                .font(.title2)
                .tracking(1)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 12) {
                    ForEach(attorneys.prefix(3)) { attorney in
                        AttorneyItemView(attorney: attorney)
                            .frame(width: 150, height: 180)
                    }
                    
                    SeeMoreButton(destination: AnyView(AttorneysView()))
                }
            }
        }
    }
    
    // MARK: - Psychology Section
    private var psychologySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Psychology Resources")
                .foregroundColor(primaryColor)
                .font(.title2)
                .tracking(1)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 12) {
                    ForEach(supportResources.prefix(3)) { psych in
                        PsychologyItemView(psych: psych)
                            .frame(width: 150, height: 180)
                    }
                    
                    SeeMoreButton(destination: AnyView(PsychologySupView()))
                }
            }
        }
    }
    
    // MARK: - Load Data Function
    private func loadData() {
        if attorneys.isEmpty {
            attorneys = decode_attorney("attorney_resources.json")
        }
        
        if supportResources.isEmpty {
            supportResources = decode_psych("psychology-resources.json")
        }
        
        if caseItems.isEmpty {
            fetchCases(term: "2024", page: 1, perPage: 5) { fetchedCases in
                caseItems = fetchedCases
            }
        }
    }
}

struct CaseItemView: View {
    var case_: CaseSummary
    
    @State private var selectedCaseDetails: CaseDetails?
    @State private var selectedCaseID: String? = nil
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            CaseCard4(
                caseItem: case_,
                primColor: Color(red: 0.078, green: 0.145, blue: 0.243),
                secColor: Color(red: 0.796, green: 0.839, blue: 0.851)
            )
            .onTapGesture {
                loadCaseDetails()
            }
            .opacity(isLoading ? 0.5 : 1)

            if isLoading {
                ProgressView()
            }

            NavigationLink(
                tag: case_.docket_number,
                selection: $selectedCaseID
            ) {
                if let details = selectedCaseDetails {
                    SingleCaseView2(caseSummary: case_, caseDetails: details)
                }
            } label: {
                EmptyView()
            }
            .hidden()
        }
    }

    private func loadCaseDetails() {
        guard !isLoading else { return }
        isLoading = true

        fetchCaseDetails(docketNumber: case_.docket_number, term: Int(case_.term) ?? 2020) { details in
            self.selectedCaseDetails = details
            self.selectedCaseID = case_.docket_number
            self.isLoading = false
        }
    }
}


// SeeMoreButton
struct SeeMoreButton: View {
    var destination: AnyView
    public var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    public var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(primaryColor)
                Text("See More")
                    .font(.caption)
                    .foregroundColor(primaryColor)
            }
            .frame(width: 150, height: 180)
            .background(secColor)
            .cornerRadius(12)
        }
    }
}


struct AttorneyItemView: View {
    var attorney: Attorney
    public var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    public var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }
    var body: some View {
        NavigationLink(destination: SingleAttorneyView(attorney: attorney)) {
            AttorneyCard(attorney: attorney, secColor: secColor, primaryColor: primaryColor)
        }
    }
}

struct PsychologyItemView: View {
    var psych: PsychologySupport
    public var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    public var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }
    
    var body: some View {
        NavigationLink(destination: SinglePsychView(psychologyItem: psych)) {
            PsychologyCard2(psych: psych, secColor: secColor, primaryColor: primaryColor)
        }
    }
}

#Preview {
    MainScreen()
}

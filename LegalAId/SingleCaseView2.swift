import SwiftUI

struct SingleCaseView2: View {
    @Environment(\.dismiss) var dismiss

    let caseSummary: CaseSummary
    let caseDetails: CaseDetails

    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }

    private var backgroundColor: Color {
        Color(red: 0.898, green: 0.910, blue: 0.914)
    }


    private func formattedDate(forEvent eventType: String) -> String {
        if let event = caseDetails.timeline.first(where: { $0.event.lowercased() == eventType }) {
            if let timestamp = event.dates.last {
                let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                return date.formatted(date: .abbreviated, time: .omitted)
            }
        }
        return "N/A"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(primaryColor)
                            .padding()
                    }
                    Spacer()
                }

                VStack(spacing: 12) {
                    Text(caseSummary.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(primaryColor)
                        .multilineTextAlignment(.center)

                    Text("Docket #: \(caseSummary.docket_number)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    HStack(spacing: 10) {
                        Text("**Granted:** \(formattedDate(forEvent: "granted"))")
                            .foregroundColor(primaryColor)
                        Text("**Argued:** \(formattedDate(forEvent: "argued"))")
                            .foregroundColor(primaryColor)
                    }
                    .font(.caption)
                    Text("**Decided:** \(formattedDate(forEvent: "decided"))")
                        .foregroundColor(primaryColor)
                    .font(.caption)

                    Text("**Petitioner:** \(caseDetails.first_party)")
                        .foregroundColor(primaryColor)
                    Text("**Respondent:** \(caseDetails.second_party)")
                        .foregroundColor(primaryColor)
                }
                .frame(maxWidth: .infinity)

                Divider().padding(.horizontal)

                Group {
                    Text("Facts of the Case")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    Text(caseDetails.facts_of_the_case)
                        .foregroundColor(.primary)

                    Text("Legal Question")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                        .padding(.top, 8)
                    Text(caseDetails.question)
                        .foregroundColor(.primary)

                    Text("Conclusion")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                        .padding(.top, 8)
                    Text(caseDetails.conclusion)
                        .foregroundColor(.primary)

                    Link("Find more information at Justia", destination: URL(string: caseSummary.justia_url ?? "justia.org")!)
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
            }

            .padding(.vertical)
            Spacer()

            Text("This information was pulled from Oyez.org")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding([.horizontal, .top])
        }
        .padding(.horizontal)
        .background(backgroundColor.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    let dummySummary = CaseSummary(
        name: "Sample Case v. State",
        href: "https://oyez.org/cases/sample",
        docket_number: "22-123",
        timeline: [],
        term: "2022",
        description: "A sample case",
        justia_url: "https://justia.com"
    )

    let dummyDetails = CaseDetails(
        name: "Sample Case v. State",
        docket_number: "22-123",
        href: "https://oyez.org/cases/sample",
        first_party: "Sample Case",
        second_party: "State",
        timeline: [],
        facts_of_the_case: "These are the facts of the case...",
        question: "Is this constitutional?",
        conclusion: "The court ruled that it was not."
    )

    return SingleCaseView2(caseSummary: dummySummary, caseDetails: dummyDetails)
}

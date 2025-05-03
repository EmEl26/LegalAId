import Foundation

class LegalDataManager {
    static let shared = LegalDataManager()
    
    // Dictionary to store legal aid data
    private var legalAidData: [String: Any]?
    // Array to store attorney resources
    private var attorneyResources: [[String: Any]]?
    // Array to store psychology resources
    private var psychologyResources: [[String: Any]]?
    
    private init() {
        loadData()
    }
    
    private func loadData() {
        legalAidData = loadJSON(filename: "legal_aid_data")
        attorneyResources = loadJSON(filename: "attorney_resources")
        psychologyResources = loadJSON(filename: "psychology_resources")
    }
    
    private func loadJSON<T>(filename: String) -> T? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Failed to load \(filename).json")
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data) as? T
        } catch {
            print("Error parsing \(filename).json: \(error)")
            return nil
        }
    }
    
    // Generate a description of the knowledge base for the system prompt
    func generateKnowledgeBaseDescription() -> String {
        var description = ""
        
        if legalAidData != nil || attorneyResources != nil || psychologyResources != nil {
            description += "\n\nYou have access to a comprehensive database of New York legal information including:"
            
            // Add rights information
            if let rights = legalAidData?["rights"] as? [[String: Any]], !rights.isEmpty {
                description += "\n• Rights information (filming police, ID requirements, wrongful termination, landlord discrimination)"
            }
            
            // Add immigration information
            if legalAidData?["Immigration Status and Law Enforcement"] != nil || 
               legalAidData?["Immigration & Law Enforcement Interactions"] != nil || 
               legalAidData?["ICE Raids & Reporting"] != nil {
                description += "\n• Immigration status and law enforcement interactions"
            }
            
            // Add tenant rights
            if legalAidData?["tenant_rights"] != nil || legalAidData?["landlord_tenant_dispute"] != nil {
                description += "\n• Tenant rights and landlord disputes"
            }
            
            // Add criminal law
            if let faqs = legalAidData?["FAQ"] as? [String: Any], !faqs.isEmpty {
                description += "\n• Criminal law procedures and rights"
            }
            
            // Add family law
            if let rights = legalAidData?["rights"] as? [[String: Any]], 
               rights.contains(where: { ($0["question"] as? String)?.contains("child support") == true || 
                                       ($0["question"] as? String)?.contains("custody") == true }) {
                description += "\n• Family law (child support, custody)"
            }
            
            // Add employment law
            if let rights = legalAidData?["rights"] as? [[String: Any]], 
               rights.contains(where: { ($0["question"] as? String)?.contains("employer") == true || 
                                       ($0["question"] as? String)?.contains("fired") == true }) {
                description += "\n• Employment law"
            }
            
            // Add legal resources
            if attorneyResources != nil && !attorneyResources!.isEmpty {
                description += "\n• Legal resources and attorney referrals"
            }
        } else {
            description += "\n\nYou have access to a comprehensive database of New York legal information including common legal questions and attorney resources."
        }
        
        return description
    }
}
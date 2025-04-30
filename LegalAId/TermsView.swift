//
//  TermsView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/24/25.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Group {
                        Text("DISCLAIMER ON CHAT BOT (1):")
                            .bold()
                        Text("LEGAL AI(D) provides general legal information, but is not a substitute for professional legal advice. While we strive for accuracy, information may not be current or applicable to your circumstances. Always consult a licensed attorney for serious legal concerns.")
                        
                        Text("DISCLAIMER ON CHAT BOT (2):")
                            .bold()
                        Text("The legal information provided by the AI chatbot is for general information purposes only, and does not constitute legal advice. Due to the nature of artificial intelligence, the responses generated may occasionally contain errors or fail to reflect current legal standards or jurisdiction-specific regulations.")
                    }

                    Divider()

                    Group {
                        Text("LEGAL AI(D) Terms and Conditions")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        Text("Below are the terms and conditions of using LEGAL AI(D), a legal resource intended to assist citizens with legal knowledge, free of cost. By using this application, users must agree to these terms and conditions, last updated on April 23, 2025.")
                        
                        Text("Users of any age are permitted to use LEGAL AI(D). If users are under the age of 18, they must have permission from a parent or guardian to access this app and its features. By using this platform, you confirm and consent that you meet these age requirements.")
                        
                        Text("LEGAL AI(D) is designed to be accessible and welcoming to individuals from underrepresented and underserved communities, especially those impacted by systemic barriers to legal access including: Low-income, BIPOC, Immigrant, and housing-insecure populations.")
                    }

                    Divider()

                    Group {
                        Text("User Responsibilities")
                            .font(.headline)
                            .bold()
                        Text("By using LEGAL AI(D), the user agrees to:")
                        Text("• Respectful Use: You will not use this app to harass, threaten, or discriminate against any persons or group based on race, ethnicity, gender identity/orientation, sexual orientation, immigration status, disability, religion, or any other protected class.")
                        Text("• You may NOT use this app for any unlawful purpose, including to provide legal advice.")
                        Text("• You may NOT use this app to try to break the law or commit a crime.")
                    }

                    Group {
                        Text("Misuse or Interference")
                            .font(.headline)
                            .bold()
                        Text("The user will not misuse or interfere with the app’s functionality, including attempting to access systems, services, or data not intended for public use.")
                        Text("The user understands the limits of the information provided by LEGAL AI(D). It is NOT legal advice, and is general legal education and community resource information.")
                    }

                    Group {
                        Text("Personal Data")
                            .font(.headline)
                            .bold()
                        Text("Avoid sharing personal information on LEGAL AI(D) such as social security numbers, case numbers, immigration status, or any other explicit personal information.")
                    }

                    Group {
                        Text("Prohibited Conduct")
                            .font(.headline)
                            .bold()
                        Text("You may not use LEGAL AI(D) to:")
                        Text("• Interfere with or disrupt the integrity or performance of the app.")
                        Text("• Attempt to gain unauthorized access to servers, systems, or data.")
                        Text("• Upload malicious software or engage in any action that could harm the platform or other users.")
                        Text("• Commercialize, resell, or exploit the app’s content without written permission.")
                    }

                    Group {
                        Text("Limitations")
                            .font(.headline)
                            .bold()
                        Text("You acknowledge that LEGAL AI(D) provides general legal and civic education, not personalized legal advice. No attorney-client relationship is created by using this platform.")
                        Text("You agree not to rely solely on AI-generated responses for legal decision-making and will seek legal counsel when necessary.")
                        Text("This app is intended to provide legal information and automated assistance. It does not constitute legal advice, nor does it create an attorney-client relationship between you and the app, its developers, or affiliates.")
                        Text("While we strive to provide accurate and up-to-date information, we do not guarantee that all responses will be correct, complete, or applicable to your particular situation. Legal outcomes are highly case-sensitive and vary based on jurisdiction or changes in law.")
                        Text("Any decisions made based on the app’s outputs are made at the discretion of the user. You are solely responsible for the verification of this information, as well as consulting with a licensed attorney regarding your circumstances.")
                        Text("Limitation of Liability: Neither the app nor its developers, affiliates, or partners should be held liable for damages that arise from the use of the app. This includes, but is not limited to, harm from errors, omissions, inaccurate information, or reliance on responses.")
                    }
                    Group {
                        Text("Ownership")
                            .font(.headline)
                            .bold()
                        Text("All content, functionality, design elements, trademarks, logos, and other intellectual property associated with the app are exclusive to LEGAL AI(D) INC. This includes text, graphics, code, data, software, and AI-generated responses. All rights are reserved.")
                        Text("We grant a limited, non-exclusive, non-transferable license to access and use the app for personal, non-commercial use in accordance with these terms and conditions. The license does not include the right to reproduce, distribute, modify, or publicly display the works of the app unless authorized by LEGAL AI(D)")
                        Text("LEGAL AI(D) and all information, content, and services provided through the app, including but not limited to AI-generated responses, are provided on an “AS IS” basis. LEGAL AI(D) makes no representations or warranties of any kind, express or implied, as to the accuracy, reliability, or availability of the information and services provided. To the fullest extent permitted by law, LEGAL AI(D) shall not be liable for any damages or intangible losses resulting from: any errors, omissions, or inaccuracies in the AI-generated legal content; downtime, bugs, or other technical malfunctions; or any reliance placed by the user based on information provided by the app. You expressly agree that your use of the LEGAL AI(D) services is at your sole risk.")
                    }
                    Group {
                        Text("Third Party Information")
                            .font(.headline)
                            .bold()
                        Text("LEGAL AI(D) may provide links, referrals, or connections to third-party organizations, legal aid providers, community resources, and other external services. These third-party services are NOT OWNED, CONTROLLED, OR OPERATED BY LEGAL AI(D) OR ITS AFFILIATES")
                        Text("We do not guarantee or take any responsibility for:")
                        Group {
                            Text("I. The accuracy or reliability of advice or information provided by third parties")
                            Text("II. The quality or availability of services offered by third-party organisations")
                            Text("III. Any harm, loss, or damage, including dissatisfaction, arising from the use of third-party services")
                        }
                        Text("While LEGAL AI(D) strives to partner with reputable and community-centered organisations, all users are encouraged to verify the credibility and credentials and offerings of any external provider before taking legal or personal action based on any outside third-party information or advice.")
                        Text("By using LEGAL AI(D), you acknowledge that:")
                        Group {
                            Text("I. Connections to third parties are offered as a community resource, not as a recommendation or legal validation.")
                            Text("II. LEGAL AI(D) is not responsible for the outcome of any interaction with third-party services, including legal aid, mental health care, or court preparation support;")
                            Text("III. You use third-party resources at your own discretion and risk.")
                        }
                        Text("The app is designed to, and may provide a connection to third-party individuals, institutions, organizations, or entities that provide legal advice, services, or assistance. By agreeing to the Terms and Conditions, you are in agreement with and acknowledge the following:")
                        Group {
                            Text("I. You acknowledge that the app does not verify, endorse, or guarantee the accuracy, reliability, or competence of any advice, services, or information given by third parties the app connects you to.")
                            Text("II. You acknowledge that we conduct an initial vetting process for any and all third-party legal services, but do not conduct routine vetting processes moving forward.")
                            Text("III. You acknowledge that the app is not responsible or liable for any bad advice that you may receive from third parties.")
                            Text("IV. You acknowledge that any legal advice received from the app or third-party legal providers is for general information purposes only, unless the third party becomes your attorney.")
                            Text("V. You acknowledge that the connection to the third-party legal provider does not guarantee attorney-client privilege. Additionally, unsaved responses on the app will be archived after 24 hours.")
                            Text("VI. You acknowledge and assume full responsibility for any actions taken based on legal advice received from third-party legal counsel.")
                        }
                        Text("We renounce any responsibility for any loss, damages, injury or consequences resulting from and related to any advice received from third-party legal counsel.")
                        Text("It is important that we define the difference between bad and wrong advice. Bad advice we defined as legally correct advice that does not suit or work in your unique circumstance(s). Wrong advice, we define as advice that is not legally sound.")
                    }
                    Group {
                        Text("Private Policy Information")
                            .font(.headline)
                            .bold()
                        Text("ENTER INFO")
                    }
                    Group {
                        Text("Accordance with Governing Law (NY AI Act)")
                            .font(.headline)
                            .bold()
                        Text("The NY AI Act defines “algorithmic discrimination” as any condition in which the use of an AI system contributes to unjustified differential treatment or impacts, disfavoring people based on their actual or perceived age, race, ethnicity, creed, religion, color, national origin, citizenship or immigration status, sexual orientation, gender identity, gender expression, military status, sex, disability, predisposing genetic characteristics, familial status, marital status, pregnancy, pregnancy outcomes, disability, height, weight, reproductive health care or autonomy, status as a victim of domestic violence, or other classification protected under state or federal laws. LEGAL AI(D) operated in compliance with the NY AI Act.")
                        Text("The NY AI Act demands that “deployers”, such as LEGAL AI(D), using a high-risk AI system9 for a consequential decision comply with certain obligations. “Deployers” is defined as “any person doing business in [New York] state that deploys a high-risk artificial intelligence decision system. Deployers must disclose to the end user in clear, conspicuous, and consumer-friendly terms that they are using an AI system that makes consequential decisions at least five business days prior to the use of such system. LEGAL AI(D) is in compliance with the NY AI Act, repeatedly disclosing that LEGAL AI(D)provides general legal information, but is not a substitute for professional legal advice. While we strive for accuracy, information may not be current or applicable to your circumstances. Always consult a licensed attorney for serious legal concerns.")
                    }
                    Group {
                        Text("Updates to Terms and Conditions")
                            .font(.headline)
                            .bold()
                        Text("These terms may be updated to reflect changes in our services, and users must agree to any updates in order to use LEGAL AI(D). Accordingly, we will update users through an app notification, and we will revise the “last updated” date at the top of the page. Continued use of the app following such updates constitutes your acceptance of the revised terms.")
                        Text("If you have any questions, concerns, or feedback about these terms, you can reach us at legalainyc@gmail.com")
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Terms & Conditions")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    TermsView()
}

import SwiftUI

struct TabBar: View {
    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                MainScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                ChatBotView()
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Chat")
                    }

                LegalToolboxView()
                    .tabItem {
                        Image(systemName: "bookmark")
                        Text("Bookmarks")
                    }

                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .accentColor(primaryColor)

            // Divider above the tab bar
            Divider()
                .background(Color.gray.opacity(0.7))
                .padding(.bottom, 60) 
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}


// Placeholder Views
struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Home Screen")
                .navigationTitle("Home")
        }
    }
}

struct ChatView: View {
    var body: some View {
        NavigationView {
            Text("Chat Screen")
                .navigationTitle("Chat")
        }
    }
}

struct BookmarksView: View {
    var body: some View {
        NavigationView {
            Text("Bookmarks Screen")
                .navigationTitle("Bookmarks")
        }
    }
}


#Preview {
    TabBar()
}

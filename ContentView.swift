import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    // Title
                    Text("Bitkub OSS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top)

                    // Subtitle
                    Text("Explore Bitkub's Open Source Software")
                        .font(.title2)
                        .foregroundColor(.black)

                    // Navigation Buttons
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 150))
                    ], spacing: 20) {
                        NavigationLink(destination: ArticleListView(title: "Projects", articles: articles)) {
                            NavigationButton(title: "Projects")
                        }
                        NavigationLink(destination: AboutView()) {
                            NavigationButton(title: "About")
                        }
                        NavigationLink(destination: CompanyView()) {
                            NavigationButton(title: "Dotmini X One")
                        }
                    }

                    Divider()

                    // Article Section
                    ForEach(articles) { article in
                        ArticleCard(article: article)
                    }
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.white, .green.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
            }
            .navigationTitle("Bitkub OSS")
        }
    }
}

struct ArticleListView: View {
    let title: String
    let articles: [Article]

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            ScrollView {
                ForEach(articles) { article in
                    ArticleCard(article: article)
                }
            }
            .padding()
        }
        .navigationTitle(title)
    }
}

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("About Bitkub OSS")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Bitkub Open Source Software (OSS) is dedicated to providing developers with tools and resources to build innovative solutions on Bitkub's ecosystem. Our projects are open and community-driven.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.green.opacity(0.2), .white]), startPoint: .top, endPoint: .bottom))
    }
}

struct CompanyView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Dotmini X One")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Dotmini X One is the proud owner of this application. We specialize in innovative software solutions that cater to modern-day challenges. From UX/UI design to full-stack development, Dotmini X One is your trusted partner in technology.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.white, .green.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
    }
}

struct NavigationButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct ArticleCard: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Image
            if let image = article.image {
                AsyncImage(url: URL(string: image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(10)
                    case .failure:
                        Color.red
                            .frame(height: 200)
                            .cornerRadius(10)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            // Title
            Text(article.title)
                .font(.headline)
                .foregroundColor(.green)

            // Description
            Text(article.description)
                .font(.subheadline)
                .foregroundColor(.black)

            // Read More Link
            if let url = article.url {
                Link("Read More", destination: url)
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

// Article Model
struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String?
    let url: URL?
}

// Sample Data
let articles = [
    Article(title: "Bitkub Wallet",
            description: "An open-source wallet solution for secure cryptocurrency management.",
            image: "https://developers.bitkubchain.com/_next/image?url=https%3A%2F%2Fbbt-bkc-storage-prod-public.s3.ap-southeast-1.amazonaws.com%2Fdevelopers%2Fapp_directories%2Fbbc035bf-5f5c-45c7-85dd-18fd8d98c031%2Fbanner%2FMetaverse%20Banner.jpg&w=1200&q=75",
            url: URL(string: "https://github.com/bitkub")),
    Article(title: "Bitkub Exchange API",
            description: "A comprehensive API for developers to interact with the Bitkub exchange platform.",
            image: "https://miro.medium.com/v2/resize:fit:720/format:webp/1*aUALwf-RhF-gXPw-li8uOw.png",
            url: URL(string: "https://bitkub.com/api")),
    Article(title: "Bitkub Blockchain Explorer",
            description: "Explore blockchain data with this open-source explorer.",
            image: "https://miro.medium.com/v2/resize:fit:720/format:webp/1*qAm6ejVszAxsKbf53HT9Eg.png",
            url: URL(string: "https://explorer.bitkubchain.io"))
]


struct BitkubOSSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .frame(minWidth: 800, minHeight: 600)
        #endif
    }
}

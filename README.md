# articale_app
BharatNXT task
# bharat_nxt_task

A new Flutter project.
# Futter Article App 
 
A Flutter app that fetches and displays a list of articles from a public 
API. 
 
## Features - List of articles - Search functionality - Detail view - Responsive UI 
 
## Setup Instructions 
1. Clone the repo: 
   git clone <your-repo-link> 
   cd flutter_article_app 
 
2. Install dependencies: 
   flutter pub get 
 
3. Run the app: 
   flutter run 
 
## Tech Stack 
- Flutter SDK: [3.13.8]
- State Management: [Bloc] 
- HTTP Client: [http] 
- Persistence: [hive]

## State Management Explanation 
[This app uses Bloc for state management, enabling a clear separation between UI and business logic. Data is fetched via events (e.g., FetchPosts) and emitted through states (HomeLoading, HomeLoaded, HomeError), allowing the UI to reactively rebuild based on current app state. This pattern promotes scalability, testability, and organized data flow throughout the app.] 
 
## Known Issues / Limitations 
[List anything incomplete or improvable] 
 
## Screenshots (Optional) 
[Add if applicable] 

# RideShareX

Simple mock Flutter app inspired by ride-sharing / carpooling apps. This repository contains a minimal, clean Material 3 Flutter app called "RideShareX". It uses in-memory mock data and demonstrates screens for searching rides, viewing results, ride details, publishing, inbox and profile management.

Features
- Material 3, null-safety, light theme with primary color `#00AEEF` and teal secondary.
- Bottom navigation with 5 tabs: Search, Publish, Your rides, Inbox, Profile.
- Screens: Search, Search Results, Ride Details, Publish, Your Rides, Inbox, Profile (with tabs).
- Mock data models: `Ride`, `User`, `Vehicle`, `Message`.
- Reusable widgets: `RideCard`, `SearchSummaryPill`, `ProfileSectionCard`.

Run (PowerShell - Windows)
```powershell
cd C:\BLABLA
flutter pub get
flutter run
```

Notes
- No external backend is used; all data is in `lib/models/mock_data.dart`.
- This project avoids any real brand names, logos or copyrighted assets.
- If you want screenshots, additional sample data, or to wire a lightweight local storage, I can add that next.

Files of interest
- `lib/main.dart` — app entry, theme and bottom navigation.
- `lib/screens/` — screen widgets.
- `lib/widgets/` — reusable UI components.
- `lib/models/` — data models and mock data.

Next steps you might want
- Implement ride creation flow and transient state storage.
- Add local persistence (shared_preferences) for recent searches.
- Connect a simple backend or Firebase for real data.

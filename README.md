# WalletWise

A beautifully designed personal finance tracker built with SwiftUI and SwiftData. Track your income, expenses, and monthly budget with an elegant dark-themed interface featuring smooth animations and intuitive gestures.

## Demo | Click on the YouTube screen

[![WalletWise Demo](https://img.youtube.com/vi/piodfxxrGD8/maxresdefault.jpg)](https://youtube.com/shorts/piodfxxrGD8)

> *Watch the full application walkthrough above.*
> 

## Features

### Transaction Management
- Add income and expense transactions with category selection
- Swipe-to-delete with confirmation dialog for safe removal
- Automatic current month filtering — no manual reset needed
- Title validation (40 character limit) and locale-aware decimal input

### Budget Tracking
- Set and edit monthly budget directly from the home screen
- Animated progress bar with color indicators (green → orange → red)
- Real-time spent vs. remaining breakdown

### Calendar View
- Browse transactions by date with a custom-built calendar grid
- Locale-aware weekday headers that adapt to device region
- Visual indicators (dots) on days with recorded transactions
- Light theme design for clear visual contrast

### Multi-Currency Support
- 30 international currencies with real-world standard names
- Alphabetically sorted currency list with search functionality
- Instant currency switching — all amounts update immediately
- Persistent currency selection across app launches

### Design & UX
- Dark/light theme harmony between screens
- Splash screen with 3D rotation animation
- Spring animations on transaction cards and category selection
- Premium squircle category icons with gradient fills and glass effects
- Haptic feedback on save and delete actions
- Full VoiceOver accessibility support

## Screenshots

| Home Screen | Add Transaction | Calendar View | Currency Picker |
|:-----------:|:---------------:|:-------------:|:---------------:|
| Dark theme with balance card, budget ring, and transaction list | Light theme with amount input, type selector, and category grid | Light theme calendar with date-based transaction browsing | Searchable currency list with 30 international currencies |

## Architecture

```
WalletWise/
├── Models/
│   ├── Transaction.swift       # SwiftData @Model entity
│   ├── Category.swift          # Transaction categories with icons and colors
│   └── Currency.swift          # 30 international currencies
├── ViewModels/
│   └── WalletViewModel.swift   # @Observable MVVM business logic
├── Views/
│   ├── HomeView.swift          # Main dashboard
│   ├── AddTransactionView.swift # Transaction entry form
│   ├── CalendarView.swift      # Date-based transaction browser
│   ├── CurrencyPickerView.swift # Currency selection
│   ├── SplashScreenView.swift  # Launch animation
│   └── Components/
│       ├── BalanceCardView.swift    # Monthly balance display
│       ├── ProgressRingView.swift   # Budget progress bar
│       ├── TransactionRowView.swift # Transaction list item
│       └── SwipeableRow.swift       # Custom swipe-to-delete gesture
├── ContentView.swift           # Root view with splash logic
├── Theme.swift                 # Color palette and hex extension
└── WalletWiseApp.swift         # App entry point
```

## Tech Stack

| Technology | Purpose |
|:-----------|:--------|
| **SwiftUI** | Declarative UI framework |
| **SwiftData** | On-device data persistence |
| **@Observable** | Reactive state management (MVVM) |
| **UserDefaults** | Lightweight settings storage (currency, budget) |
| **[Stitch](https://stitch.withgoogle.com)** | UI/UX design and prototyping |

## Design Principles

- **MVVM Architecture** — Clean separation between views and business logic
- **SOLID Principles** — Single responsibility per file, open for extension
- **OOP** — Observable class-based ViewModel with encapsulated logic
- **No Force Unwraps** — Safe optional handling throughout the codebase
- **Proper Error Handling** — `do/catch` blocks on all SwiftData operations
- **Accessibility** — VoiceOver labels on all interactive elements
- **Pure SwiftUI** — Built entirely with SwiftUI framework

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/aisel-mohbaliyeva/WalletWise.git
```

2. Open the project in Xcode:
```bash
cd WalletWise
open WalletWise.xcodeproj
```

3. Select a simulator or connected device and press `Cmd + R` to build and run.

## Categories

| Icon | Category | Color |
|:----:|:---------|:------|
| 🛒 | Market | Orange |
| 🍴 | Restaurant | Red |
| 🛍️ | Shopping | Pink |
| 🎓 | Education | Blue |
| ✈️ | Travel | Cyan |
| 🏠 | Bills | Yellow |
| 📡 | TV & Internet | Teal |
| 🚌 | Transport | Indigo |
| 💊 | Pharmacy | Green |
| ⛽ | Fuel | Brown |
| 🏃 | Sports | Mint |
| ⋯ | Other | Gray |

## Supported Currencies

AED, AUD, AZN, BRL, CAD, CHF, CNY, EGP, EUR, GBP, GEL, HKD, ILS, INR, JPY, KRW, KZT, MXN, NGN, NOK, PLN, RUB, SAR, SEK, SGD, THB, TRY, UAH, USD, ZAR

## Author

**Aysel Mohbaliyeva**

- GitHub: [@aisel-mohbaliyeva](https://github.com/aisel-mohbaliyeva)
- Email: ayselmohbaliyeva22@gmail.com

## License

This project is available under the MIT License. See the [LICENSE](LICENSE) file for details.

# WalletWise

Personal finance tracker built with SwiftUI and SwiftData.

## Demo

<div align="center">

<a href="https://youtube.com/shorts/piodfxxrGD8" target="_blank">
  <img src="https://img.youtube.com/vi/piodfxxrGD8/maxresdefault.jpg" alt="WalletWise Demo" width="280">
</a>

<br><br>

<a href="https://youtube.com/shorts/piodfxxrGD8" target="_blank">
  <img src="https://img.shields.io/badge/▶_Watch_Demo-YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="Watch on YouTube">
</a>

</div>

## Screenshots

<div align="center">

<img src="Screenshots/1.png" alt="Splash Screen" width="230">&nbsp;&nbsp;&nbsp;<img src="Screenshots/2.png" alt="Home Screen" width="230">

<br>

<img src="Screenshots/3.png" alt="Add Transaction" width="230">&nbsp;&nbsp;&nbsp;<img src="Screenshots/4.png" alt="Calendar View" width="230">&nbsp;&nbsp;&nbsp;<img src="Screenshots/5.png" alt="Currency Picker" width="230">

</div>

## Features

- Track income and expenses with 12 categories
- Monthly budget with animated progress bar (green → orange → red)
- Calendar view for date-based transaction browsing
- 30 international currencies with instant switching
- Swipe-to-delete with haptic feedback
- Full VoiceOver accessibility

## Tech Stack

| Technology | Purpose |
|:-----------|:--------|
| **SwiftUI** | Declarative UI framework |
| **SwiftData** | On-device data persistence |
| **@Observable** | Reactive state management (MVVM) |
| **UserDefaults** | Lightweight settings storage |
| **[Stitch](https://stitch.withgoogle.com)** | UI/UX design and prototyping |

## Architecture

- **MVVM** with `@Observable` ViewModel
- **SOLID** — single responsibility per file
- **OOP** — class-based ViewModel with encapsulated logic
- Safe optional handling, `do/catch` error handling, no force unwraps

```
WalletWise/
├── Models/          # Transaction, Category, Currency
├── ViewModels/      # WalletViewModel (@Observable)
├── Views/           # HomeView, AddTransaction, Calendar, CurrencyPicker
│   └── Components/  # BalanceCard, ProgressRing, TransactionRow, SwipeableRow
├── Theme.swift      # Color palette
└── ContentView.swift
```

## Requirements

- iOS 17.0+ / Xcode 15.0+ / Swift 5.9+

## Installation

```bash
git clone https://github.com/aisel-mohbaliyeva/WalletWise.git
cd WalletWise
open WalletWise.xcodeproj
```

## Author

**Aysel Mohbaliyeva** — [@aisel-mohbaliyeva](https://github.com/aisel-mohbaliyeva)

## License

MIT License. See [LICENSE](LICENSE) for details.

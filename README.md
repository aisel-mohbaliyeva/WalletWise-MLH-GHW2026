<p align="center">
  <img src="WalletWise/Assets.xcassets/AppIcon.appiconset/AppIcon.png" alt="WalletWise" width="80">
</p>

<h1 align="center">WalletWise</h1>

<p align="center">Personal finance tracker built with SwiftUI and SwiftData</p>

<br>

## Demo

<div align="center">

<a href="https://youtube.com/shorts/piodfxxrGD8" target="_blank">
  <img src="https://img.youtube.com/vi/piodfxxrGD8/maxresdefault.jpg" alt="WalletWise Demo" width="850">
  <img src="https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="YouTube">
</a>

</div>

<br>

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

## Screenshots

<div align="center">

<img src="Screenshots/1.png" alt="Splash Screen" width="200">&nbsp;&nbsp;&nbsp;<img src="Screenshots/2.png" alt="Home Screen" width="200">

<br>

<img src="Screenshots/3.png" alt="Add Transaction" width="200">&nbsp;&nbsp;&nbsp;<img src="Screenshots/4.png" alt="Calendar View" width="200">&nbsp;&nbsp;&nbsp;<img src="Screenshots/5.png" alt="Currency Picker" width="200">

</div>

## Architecture

```
MVVM  ·  @Observable  ·  SOLID  ·  OOP  ·  do/catch  ·  No Force Unwraps
```

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

iOS 17.0+ · Xcode 15.0+ · Swift 5.9+

## Installation

```bash
git clone https://github.com/aisel-mohbaliyeva/WalletWise.git
cd WalletWise && open WalletWise.xcodeproj
```

## Author

**Aysel Mohbaliyeva** — [@aisel-mohbaliyeva](https://github.com/aisel-mohbaliyeva)

## License

MIT License. See [LICENSE](LICENSE) for details.

# BarebudGet 💰

A minimalist and user-friendly expense tracking application that works fully offline. Built with Flutter for cross-platform compatibility.

## Features ✨

### Core Functionality

- **Quick Transaction Logging**: Add income and expenses with just a few taps
- **Smart Categorization**: Pre-built categories with custom icons and colors
- **Multi-Currency Support**: Track expenses in different currencies (USD, EUR, GBP, etc.)
- **Recurring Transactions**: Set up daily, weekly, monthly, or yearly recurring expenses
- **Custom Categories**: Add and manage your own transaction categories

### Analytics & Insights

- **Visual Charts**: Pie charts for spending by category, line charts for trends
- **Time-based Analysis**: View daily, weekly, monthly, and yearly summaries
- **Category Breakdown**: Detailed spending analysis by category
- **Balance Tracking**: Real-time balance calculation with income vs expenses

### Data Management

- **Offline First**: All data stored locally using SQLite - no internet required
- **Data Export**: Export transactions to CSV or PDF formats
- **Privacy Focused**: Your financial data never leaves your device
- **Fast Performance**: Optimized for quick loading and smooth interactions

### User Experience

- **Clean Modern UI**: Soft colors, minimal shadows, and simple typography
- **Intuitive Navigation**: Bottom tab bar with Home, Analytics, History, and Settings
- **Quick Actions**: Floating action button for fast transaction entry
- **Dark/Light Theme**: Customizable appearance (coming soon)

## Screenshots 📱

The app features a clean, modern interface with:

- **Dashboard**: Shows daily expenses, balance card, and recent transactions
- **Analytics**: Interactive charts and spending insights
- **History**: Chronological transaction list with filtering options
- **Settings**: App preferences and data management tools

## Technical Details 🛠️

### Architecture

- **Framework**: Flutter 3.9.2+
- **Database**: SQLite with sqflite package
- **Charts**: fl_chart for beautiful data visualization
- **State Management**: StatefulWidget with local state
- **File Operations**: path_provider for local storage

### Key Packages

- `sqflite`: Local database storage
- `fl_chart`: Interactive charts and graphs
- `intl`: Date formatting and internationalization
- `csv`: CSV export functionality
- `pdf`: PDF report generation
- `share_plus`: Native sharing capabilities
- `font_awesome_flutter`: Rich icon set

### Database Schema

- **Transactions**: id, title, amount, category, type, date, description, currency, recurring info
- **Categories**: id, name, icon, color, type (income/expense)

## Getting Started 🚀

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

### Building

- **Android**: `flutter build apk --release`
- **iOS**: `flutter build ios --release`
- **Web**: `flutter build web --release`

## Privacy & Security 🔒

BarebudGet is designed with privacy as a core principle:

- **100% Offline**: No data transmission to external servers
- **Local Storage**: All data stored securely on your device
- **No Analytics**: No tracking or usage analytics
- **No Permissions**: Minimal system permissions required
- **Open Source**: Transparent codebase for security review

## Roadmap 🗺️

### Upcoming Features

- [ ] Budget planning and alerts
- [ ] Receipt photo attachment
- [ ] Advanced filtering and search
- [ ] Data backup and restore
- [ ] Multiple account support
- [ ] Investment tracking
- [ ] Bill reminders
- [ ] Expense splitting

### UI Enhancements

- [ ] Dark theme implementation
- [ ] Custom color themes
- [ ] Accessibility improvements
- [ ] Tablet-optimized layouts

## Contributing 🤝

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Support 💬

For support, feature requests, or bug reports, please open an issue on GitHub.

---

**BarebudGet** - Keep your finances simple, private, and under control. 🎯

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

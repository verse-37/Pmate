# pmate

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Notes for developers
### Textual resources:

- [Localization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)

In the project, we use `arb` files to store the textual resources. To generate the localization files, run the following command:
```bash
flutter gen-l10n
```
Styles for Text widgets are defined in `theme.dart` file.
- For title-like text, use `displayLarge` style.
- For heading-like text, use `displayMedium` style.
- For subheading-like text, use `displaySmall` style.
- For body-like text, use `bodyMedium` and `bodySmall` styles.
- For label-like text, use `bodySmall` style.
- For button text, use `labelLarge` style.
- For caption-like text, use `labelSmall` style.
- Ask the designer / head developer for the correct style for new text widgets.

## Icons
- Browse on https://fonts.google.com/icons.

## Git Commit Messages
- Use the present tense ("Add feature" not "Added feature").
- Limit the first line to 50 characters or less.
- Reference issues and pull requests liberally after the first line.
- When only changing documentation, include `[ci skip]` in the commit title.
### PREFIX
- [version_code]: Watch `[git log]` to get the latest version code.
- [author]: The author of the commit.
- [style]: stable (Deployable code), incomplete (Code that is not deployable), refactor (Code that improves the code structure), test (Code that adds or modifies tests).
- Example: v1.1.2+1Q stable. ...

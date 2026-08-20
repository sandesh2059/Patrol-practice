import 'package:flutter/material.dart';

enum AppTheme { system, light, dark }

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  AppTheme _selectedTheme = AppTheme.system;
  String _selectedLanguage = 'English';
  double _fontSize = 14;

  static const _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Nepali',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            key: const Key('notificationsSwitch'),
            title: const Text('Enable notifications'),
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),
          SwitchListTile(
            key: const Key('darkModeSwitch'),
            title: const Text('Dark mode'),
            value: _darkModeEnabled,
            onChanged: (value) => setState(() => _darkModeEnabled = value),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Theme', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          RadioListTile<AppTheme>(
            key: const Key('themeSystemRadio'),
            title: const Text('System default'),
            value: AppTheme.system,
            groupValue: _selectedTheme,
            onChanged: (value) => setState(() => _selectedTheme = value!),
          ),
          RadioListTile<AppTheme>(
            key: const Key('themeLightRadio'),
            title: const Text('Light'),
            value: AppTheme.light,
            groupValue: _selectedTheme,
            onChanged: (value) => setState(() => _selectedTheme = value!),
          ),
          RadioListTile<AppTheme>(
            key: const Key('themeDarkRadio'),
            title: const Text('Dark'),
            value: AppTheme.dark,
            groupValue: _selectedTheme,
            onChanged: (value) => setState(() => _selectedTheme = value!),
          ),
          const Divider(),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              key: const Key('languageDropdown'),
              value: _selectedLanguage,
              items: _languages
                  .map(
                    (lang) => DropdownMenuItem(value: lang, child: Text(lang)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _selectedLanguage = value);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Font size: ${_fontSize.toStringAsFixed(0)}'),
          ),
          Slider(
            key: const Key('fontSizeSlider'),
            value: _fontSize,
            min: 10,
            max: 24,
            divisions: 14,
            label: _fontSize.toStringAsFixed(0),
            onChanged: (value) => setState(() => _fontSize = value),
          ),
        ],
      ),
    );
  }
}

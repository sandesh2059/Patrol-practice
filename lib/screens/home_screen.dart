import 'package:flutter/material.dart';

import '../models/user.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  int _counter = 0;
  final List<String> _tasks = ['Write Patrol test', 'Review PR', 'Ship release'];
  final _newTaskController = TextEditingController();

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  void _addTask() {
    final text = _newTaskController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _tasks.add(text);
      _newTaskController.clear();
    });
  }

  void _removeTask(int index) {
    setState(() => _tasks.removeAt(index));
  }

  Future<void> _showLogoutDialog(AppUser? user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('logoutDialog'),
        title: const Text('Log out?'),
        content: const Text('You will need to log in again to continue.'),
        actions: [
          TextButton(
            key: const Key('cancelLogoutButton'),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            key: const Key('confirmLogoutButton'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  Widget _buildCounterTab() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Counter demo'),
          const SizedBox(height: 8),
          Text(
            '$_counter',
            key: const Key('counterValue'),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                key: const Key('decrementButton'),
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => setState(() => _counter--),
              ),
              const SizedBox(width: 24),
              IconButton(
                key: const Key('incrementButton'),
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => setState(() => _counter++),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key('newTaskField'),
                  controller: _newTaskController,
                  decoration: const InputDecoration(
                    labelText: 'New task',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _addTask(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                key: const Key('addTaskButton'),
                icon: const Icon(Icons.add),
                onPressed: _addTask,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            key: const Key('taskList'),
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                key: Key('taskItem_$index'),
                leading: const Icon(Icons.check_circle_outline),
                title: Text(_tasks[index]),
                trailing: IconButton(
                  key: Key('deleteTask_$index'),
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _removeTask(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as AppUser?;

    final tabs = [_buildCounterTab(), _buildTasksTab()];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrol Practice'),
        actions: [
          IconButton(
            key: const Key('profileButton'),
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: user);
            },
          ),
          IconButton(
            key: const Key('settingsButton'),
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          IconButton(
            key: const Key('logoutButton'),
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(user),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedTab, children: tabs),
      bottomNavigationBar: NavigationBar(
        key: const Key('bottomNav'),
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            key: Key('counterTabButton'),
            icon: Icon(Icons.numbers_outlined),
            label: 'Counter',
          ),
          NavigationDestination(
            key: Key('tasksTabButton'),
            icon: Icon(Icons.checklist_outlined),
            label: 'Tasks',
          ),
        ],
      ),
    );
  }
}

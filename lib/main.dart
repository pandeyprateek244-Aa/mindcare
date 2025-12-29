
import 'package:flutter/material.dart';

void main() {
  runApp(const MindCareApp());
}

class MindCareApp extends StatelessWidget {
  const MindCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindCare',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MindCare 🧠'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          featureTile(context, 'Daily Mood Check', Icons.mood, const MoodScreen()),
          featureTile(context, 'Support Chat', Icons.chat, const ChatScreen()),
          featureTile(context, 'Breathing Exercise', Icons.self_improvement, const BreathScreen()),
          featureTile(context, 'Emergency Help', Icons.warning, const EmergencyScreen()),
        ],
      ),
    );
  }

  Widget featureTile(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }
}

// ---------------- MOOD ----------------
class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moods = ['😊 Happy', '😐 Okay', '😞 Sad', '😰 Anxious', '😡 Angry'];

    return Scaffold(
      appBar: AppBar(title: const Text('How are you today?')),
      body: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Text(moods[i]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mood saved: ${moods[i]}')),
              );
            },
          );
        },
      ),
    );
  }
}

// ---------------- CHAT ----------------
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  void send() {
    if (controller.text.isEmpty) return;
    setState(() {
      messages.add('You: ${controller.text}');
      messages.add(
          'MindCare: I hear you. You are not alone. Take a slow breath with me 🌿');
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: messages.map((m) => ListTile(title: Text(m))).toList(),
            ),
          ),
          Row(
            children: [
              Expanded(child: TextField(controller: controller)),
              IconButton(icon: const Icon(Icons.send), onPressed: send),
            ],
          )
        ],
      ),
    );
  }
}

// ---------------- BREATHING ----------------
class BreathScreen extends StatelessWidget {
  const BreathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Breathing Exercise')),
      body: const Center(
        child: Text(
          'Inhale 4 sec 🌬️\nHold 4 sec ✋\nExhale 6 sec 🌱\nRepeat',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

// ---------------- EMERGENCY ----------------
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Help')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'If you feel unsafe or overwhelmed:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text('📞 Kiran Helpline (India): 1800-599-0019'),
            Text('📞 AASRA: +91-9820466726'),
            SizedBox(height: 20),
            Text(
              'This app supports mental well-being.\nIt does not replace professional help.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

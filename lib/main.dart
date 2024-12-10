import 'package:flutter/material.dart';

void main() {
  runApp(const TekaTekiSUKIApp());
}

class TekaTekiSUKIApp extends StatefulWidget {
  const TekaTekiSUKIApp({Key? key}) : super(key: key);

  @override
  _TekaTekiSUKIAppState createState() => _TekaTekiSUKIAppState();
}

class _TekaTekiSUKIAppState extends State<TekaTekiSUKIApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default to light mode

  void _toggleTheme(bool isDarkTheme) {
    setState(() {
      _themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTS (Teka Teki SUKI)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: _themeMode,
      home: HomePage(toggleTheme: _toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(bool) toggleTheme;

  const HomePage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'APLIKASI TTS (Kelompok SUKIBOYS)',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Selamat Datang di (TTS) Teka Teki SUKI!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Jawabannya di luar nalar cuy, jangan serius serius amat..',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildCustomButton(
                  context,
                  icon: Icons.play_arrow,
                  label: 'Mulai Game',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LevelSelectionScreen()),
                    );
                  },
                ),
                _buildCustomButton(
                  context,
                  icon: Icons.settings,
                  label: 'Pengaturan',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen(toggleTheme: toggleTheme)),
                    );
                  },
                ),
                
                _buildCustomButton(
                  context,
                  icon: Icons.exit_to_app,
                  label: 'Keluar',
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context,
      {required IconData icon,
      required String label,
      Color color = Colors.blueAccent,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 26),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 52),
        elevation: 6,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      ),
      onPressed: onPressed,
    );
  }
}

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({Key? key}) : super(key: key);

  void _confirmLevel(BuildContext context, int level) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Level'),
          content: Text('Apakah Anda yakin ingin bermain di Level $level?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionScreen(level: level),
                  ),
                );
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Level kesulitan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: List.generate(3, (index) {
            int level = index + 1; // Level mulai dari 1
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Level $level',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => _confirmLevel(context, level),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  final int level;

  const QuestionScreen({Key? key, required this.level}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final Map<int, List<Map<String, String>>> _levels = {
    1: [
      {'question': 'daun daun apa yang bolong?', 'answer': 'daunat'},
      {'question': 'buah yg suka marah?', 'answer': 'kelapa sewot'},
    ],
    2: [
      {'question': 'kampus yg suka manggil?', 'answer': 'UI'},
      {'question': 'ikan apa yang bisa terbang?', 'answer': 'ikan pegasus'},
    ],
    3: [
      {'question': 'gunung apa yang pinter banget?', 'answer': 'gunung sage'},
      {'question': 'lagu apa yang cengeng?', 'answer': 'lagu nangis'},
    ],
  };

  int _currentQuestionIndex = 0;
  String _userAnswer = '';
  String _feedbackMessage = '';
  int _helpCount = 3;
  bool _isCorrectAnswer = false;

  void _checkAnswer() {
    // Peringatan jika kolom jawaban kosong
    if (_userAnswer.isEmpty) {
      setState(() {
        _feedbackMessage = 'Kolom jawaban harus diisi!';
      });
      return;
    }

    final correctAnswer =
        _levels[widget.level]![_currentQuestionIndex]['answer']!.toLowerCase();
    if (_userAnswer.toLowerCase() == correctAnswer) {
      setState(() {
        _feedbackMessage = 'Benar! Jawaban Anda tepat!';
        _isCorrectAnswer = true;
      });
    } else {
      setState(() {
        _feedbackMessage = 'Jawaban Anda salah, coba lagi!';
        _isCorrectAnswer = false;
      });
    }
  }

  void _useHelp() {
    if (_helpCount > 0) {
      setState(() {
        _helpCount--;
        _feedbackMessage =
            'Huruf pertama adalah: ${_levels[widget.level]![_currentQuestionIndex]['answer']!.substring(0, 1)}';
      });
    } else {
      setState(() {
        _feedbackMessage = 'Anda tidak memiliki bantuan lagi!';
      });
    }
  }

  void _nextQuestionOrLevel() {
    if (_isCorrectAnswer) {
      if (_currentQuestionIndex < _levels[widget.level]!.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _userAnswer = '';
          _feedbackMessage = '';
          _isCorrectAnswer = false;
        });
      } else {
        _showEndLevelDialog();
      }
    }
  }

  void _showEndLevelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selamat!'),
          content: const Text('Apakah Anda ingin melanjutkan ke level berikutnya?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Logika untuk melanjutkan ke level berikutnya
                if (widget.level < _levels.keys.length) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionScreen(level: widget.level + 1),
                    ),
                  );
                } else {
                  // Jika tidak ada level berikutnya
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selamat! Anda telah menyelesaikan semua level!')),
                  );
                }
              },
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _levels[widget.level]![_currentQuestionIndex]['question'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertanyaan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _userAnswer = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Jawaban Anda',
                hintText: 'Masukkan jawaban...',
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('Periksa Jawaban'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _feedbackMessage,
              style: TextStyle(
                fontSize: 18,
                color: _isCorrectAnswer ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text('Bantuan tersisa: $_helpCount'),
            ElevatedButton(
              onPressed: _useHelp,
              child: const Text('Gunakan Bantuan'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextQuestionOrLevel,
              child: const Text('Lanjut'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SettingsScreen extends StatefulWidget {
  final Function(bool) toggleTheme;

  const SettingsScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _volume = 0.5;
  bool _isNotificationEnabled = true;
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Section
            const SizedBox(height: 20),
            const Text(
              'Tema Aplikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 1, color: Colors.grey),
            SwitchListTile(
              title: const Text('Mode Gelap'),
              value: _isDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  _isDarkTheme = value;
                  widget.toggleTheme(_isDarkTheme);
                });
              },
            ),
            
            // Notification Section
            const SizedBox(height: 30),
            const Text(
              'Notifikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 1, color: Colors.grey),
            SwitchListTile(
              title: const Text('Aktifkan Notifikasi Suara'),
              value: _isNotificationEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isNotificationEnabled = value;
                });
              },
            ),

            // Volume Section
            const SizedBox(height: 30),
            const Text(
              'Volume Notifikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 1, color: Colors.grey),
            Slider(
              value: _volume,
              onChanged: (newVolume) {
                setState(() {
                  _volume = newVolume;
                });
              },
              min: 0,
              max: 1,
              divisions: 10,
              label: (_volume * 100).toStringAsFixed(0),
            ),

            // Back Button
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(180, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Kembali'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


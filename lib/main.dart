import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> tasks = [];

  void tambahTugas() {
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        tasks.add({'title': controller.text.trim(), 'done': false});
        controller.clear();
      });
    }
  }

  void ubahStatusTugas(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  void hapusTugas(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Task Tracker',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF455A64),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama tugas',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onSubmitted: (_) => tambahTugas(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: tambahTugas,
                  child: const Text('Tambah'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Daftar Tugas'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final bool done = tasks[index]['done'];
                  return ListTile(
                    dense: true,
                    leading: Checkbox(
                      value: done,
                      onChanged: (_) => ubahStatusTugas(index),
                    ),
                    title: Text(
                      tasks[index]['title'],
                      style: TextStyle(
                        fontSize: 14,
                        decoration: done ? TextDecoration.lineThrough : null,
                        color: done ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => hapusTugas(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

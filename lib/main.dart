import 'package:campingtool_app/AddPage.dart';
import 'package:campingtool_app/model/campingtool.dart';
import 'package:campingtool_app/provider/campingtool_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CampingtoolProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'อุปกรณ์ตั้งแคมป์',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(110, 17, 255, 0),
        ),
      ),
      home: const MyHomePage(title: 'อุปกรณ์ตั้งแคมป์'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<CampingtoolProvider>(
        builder: (context, provider, child) {
          int itemCount = provider.campingTools.length;
          if (itemCount == 0) {
            return const Center(
              child: Text("ยังไม่มีอุปกรณ์", style: TextStyle(fontSize: 20)),
            );
          } else {
            return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, int index) {
                Campingtool data = provider.campingTools[index];
                return Dismissible(
                  key: Key(data.keyID.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    provider.removeCampingTool(data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${data.toolName} ถูกลบ")),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      title: Text(data.toolName),
                      subtitle: Text(
                        "หมวดหมู่: ${data.category} จำนวน: ${data.quantity}",
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddPage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Drag and Drop Demo',
      home: DragAndDropScreen(),
    );
  }
}

class DragAndDropScreen extends StatefulWidget {
  const DragAndDropScreen({super.key});

  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<Widget> droppedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag and Drop PoC'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Draggable<String>(
                    data: 'Text Item',
                    feedback: const Material(
                      child: Text(
                        'This is just a Text Item',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Text Item',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Draggable<String>(
                    data: 'Image Item',
                    feedback: Material(
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://collectionperformance.com/wp-content/uploads/2023/12/top-10-networking-technology-1.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Image Item',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Drop target section
            Expanded(
              child: DragTarget<String>(
                onAcceptWithDetails: (data) {
                  setState(() {
                    if (data.data == 'Text Item') {
                      droppedItems.add(
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'This is just a Text Item',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    } else if (data.data == 'Image Item') {
                      droppedItems.add(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://collectionperformance.com/wp-content/uploads/2023/12/top-10-networking-technology-1.jpg',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      );
                    }
                  });
                },
                builder: (BuildContext context, List<String?> candidateData,
                    List<dynamic> rejectedData) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey)
                    ),
                    width: double.infinity,
                    child: Column(
                      children: droppedItems.isNotEmpty
                          ? droppedItems
                          : [const Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Text('Drag items here'),
                          )],
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
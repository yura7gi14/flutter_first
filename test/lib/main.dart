import 'package:flutter/material.dart';

void main() {
  runApp(MemoApp());
}

class MemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      home: MemoList(),
    );
  }
}

class MemoList extends StatefulWidget {
  @override
  _MemoListState createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  List<String> memos = [];

  TextEditingController controller = TextEditingController();

  void addMemo(String memo) {
    setState(() {
      memos.add(memo);
    });
  }

  void editMemo(int index, String memo) {
    setState(() {
      memos[index] = memo;
    });
  }

  void deleteMemo(int index) {
    setState(() {
      memos.removeAt(index);
    });
  }

  void openAddMemoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Memo'),
          content: TextField(
            controller: controller,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                addMemo(controller.text);
                controller.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void openEditMemoDialog(int index, String memo) {
    TextEditingController editController = TextEditingController(text: memo);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Memo'),
          content: TextField(
            controller: editController,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                editMemo(index, editController.text);
                Navigator.of(context).pop();
              },
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
        title: Text('Memo List'),
      ),
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                openEditMemoDialog(index, memos[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(memos[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddMemoDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

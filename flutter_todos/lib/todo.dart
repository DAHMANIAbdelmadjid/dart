import 'package:flutter/material.dart';
import 'package:flutter_todos/appbarcu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todo = [];
  List<String> todobool = [];
  TextEditingController newNode = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences to = await SharedPreferences.getInstance();
    SharedPreferences tobool = await SharedPreferences.getInstance();

    todo = to.getStringList("viwenode")?? [""]; // Provide a default value if null
    todobool = tobool.getStringList("boolnode")?? [""];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff16325B),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          testAlert(context);
        },
        backgroundColor: const Color(0xffFFDC7F),
        label: const Text('Add to'),
        icon: const Icon(Icons.edit),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: AppBarCustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff78B7D0),
                  Color(0xff227B94),
                ],
              ),
            ),
            child: const Center(
              child: Text(
                'Todolist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: null,
        child: ListView.builder(
          itemBuilder: (context, i) {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: const Color(0xffFFDC7F),
              title: Text(
                todo[i],
                style: const TextStyle(color: Colors.white),
              ),
              // value:true ,
              value: (todobool[i]).toLowerCase() == 'true',
              onChanged: (val) async {
                SharedPreferences to = await SharedPreferences.getInstance();
                SharedPreferences tobool =
                    await SharedPreferences.getInstance();
                setState(() {
                  todobool[i] = "$val";
                  if (val == false) {
                    todo.remove(todo[i]);
                    todobool.remove(todobool[i]);
                    to.setStringList("viwenode", todo);
                    tobool.setStringList("boolnode", todobool);
                  }
                });
              },
            );
          },
          itemCount: todo.length,
        ),
      ),
    );
  }

  void testAlert(BuildContext context) {
    var alert = AlertDialog(
      title: const Text("New task"),
      content: TextField(controller: newNode),
      actions: [
        TextButton(
          onPressed: () async {
            SharedPreferences to = await SharedPreferences.getInstance();
            SharedPreferences tobool = await SharedPreferences.getInstance();
            setState(() {
              todo = (to.getStringList("viwenode") ?? [""]);
              todobool = (tobool.getStringList("boolnode") ?? [""]);
              todo.add(newNode.text);
              todobool.add("false");
              newNode.clear();
              to.setStringList("viwenode", todo);
              tobool.setStringList("boolnode", todobool);
            });
            Navigator.of(context).pop();
          },
          child: const Text("Ok"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }
}

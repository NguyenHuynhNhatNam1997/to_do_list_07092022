import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:to_do_list_07092022/todo_model.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

// Những thao tác sự kiện event trong flutter Staffull đều viết bên trong State<Object>
class _ToDoListPageState extends State<ToDoListPage> {
  late bool isShowForm;
  late List<ToDoModel> listToDoModels;

  @override
  void initState() {
    isShowForm = false;
    listToDoModels = [];
    super.initState();
  }

  void setShowForm(bool isShowForm) {
    setState(() {
      this.isShowForm = isShowForm;
    });
  }

  void addWork(ToDoModel toDoModel) {
    setState(() {
      listToDoModels.add(toDoModel);
    });
  }

  void deleteWork(int position) {
    setState(() {
      listToDoModels.removeAt(position);
    });
  }

  void updateWork(int position, ToDoModel toDoModel) {
    setState(() {
      listToDoModels[position] = toDoModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To do list Nam"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            shouldShowForm(isShowForm, setShowForm, addWork),
            Expanded(
              child: ListView.builder(
                itemCount: listToDoModels.length,
                itemBuilder: (context, position) {
                  return ItemTodo(
                      listToDoModels[position], position, deleteWork);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shouldShowForm(
      bool isShowForm, Function setShowForm, Function addWork) {
    final TextEditingController textTitle = TextEditingController();
    final TextEditingController textDescription = TextEditingController();
    if (isShowForm) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textTitle,
              decoration: const InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: textDescription,
              decoration: const InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      String titleAdd = textTitle.text.toString();
                      String descriptionAdd = textDescription.text.toString();
                      if (titleAdd.isEmpty || descriptionAdd.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Bạn chưa nhập đủ thông tin")));
                      }
                      addWork(ToDoModel(
                          title: titleAdd, description: descriptionAdd));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all(
                        Size.fromHeight(50),
                      ),
                    ),
                    child: const Text(
                      "Add work",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      setShowForm(!isShowForm);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all(
                        Size.fromHeight(50),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          setShowForm(!isShowForm);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(color: Colors.red)
            ))),
        child: const Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  Widget ItemTodo(ToDoModel toDoModel, int position, Function deleteWork) {
    return Container(
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                final TextEditingController textTitle = TextEditingController();
                textTitle.text = toDoModel.title;
                final TextEditingController textDescription =
                    TextEditingController();
                textDescription.text = toDoModel.description;
                return Dialog(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: textTitle,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: textDescription,
                          decoration: const InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // side: BorderSide(color: Colors.red)
                                  )),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size.fromHeight(50)),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 25),
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  if (textTitle.text.isEmpty ||
                                      textDescription.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Ban chua truyen du thong tin")));
                                    return;
                                  }
                                  updateWork(
                                      position,
                                      ToDoModel(
                                          title: textTitle.text,
                                          description: textDescription.text));
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // side: BorderSide(color: Colors.red)
                                  )),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size.fromHeight(50)),
                                ),
                                child: const Text(
                                  "Update",
                                  style: TextStyle(fontSize: 25),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: ListTile(
          title: Text(toDoModel.title),
          subtitle: Text(toDoModel.description),
          trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                deleteWork(position);
              }),
        ),
      ),
    );
  }
}

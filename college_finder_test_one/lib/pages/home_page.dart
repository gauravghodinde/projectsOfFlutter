import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:college_finder_test_one/pages/expense_card.dart';
import 'package:college_finder_test_one/database/dataase_helper.dart';
// ignore: must_be_immutable

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePagestate();
}

class HomePagestate extends State<HomePage> {
  var date = "21 July";
  var totalSpent = "\$10000";
  var todaySpent = "10000";

  static List<Map<String, dynamic>> items = [];
  bool isLoading = true;

  void getAllItems() async {
    //gets all items and stores it in items
    final data = await SQLHelper.getItems();
    setState(() {
      items = data;

      isLoading = false;
    });
    print(items);
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  TypeLabel? selectedtype;

  @override
  void initState() {
    super.initState();
    getAllItems(); // Loading the diary when the app starts
  }

  Future<void> addItem() async {
    await SQLHelper.createItem(titleController.text, descriptionController.text,
        int.parse(priceController.text), typeController.text);
    getAllItems();
    print("get all items .. additem");
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<TypeLabel>> iconEntries =
        <DropdownMenuEntry<TypeLabel>>[];
    for (final TypeLabel icon in TypeLabel.values) {
      iconEntries
          .add(DropdownMenuEntry<TypeLabel>(value: icon, label: icon.label));
    }
    return Scaffold(
      backgroundColor: Color(0xffCEF2E1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffCEF2E1), size: 30),
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: const Color(0xff1B8C42),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(25),
        //       bottomLeft: Radius.circular(25)),
        // ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(date,
                style:
                    GoogleFonts.lato(fontSize: 22, color: Color(0xffCEF2E1))),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 230,
            width: 500,
            decoration: const BoxDecoration(
              color: const Color(0xff1B8C42),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35)),
            ),
            child: Column(
              children: <Widget>[
                Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 180),
                      child: Text("Total spent this month",
                          style: GoogleFonts.lato(
                              color: Color(0xffCEF2E1), fontSize: 18)),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 150),
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Text(totalSpent,
                                overflow: TextOverflow.visible,
                                softWrap: false,
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                    color: Color(0xffCEF2E1), fontSize: 64))))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Today",
                              style: GoogleFonts.lato(
                                  fontSize: 30, color: Color(0xffCEF2E1)),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 170),
                          child: Padding(
                              padding: EdgeInsets.only(right: 0),
                              child: Text("$todaySpent /-",
                                  style: GoogleFonts.lato(
                                      fontSize: 30, color: Color(0xffCEF2E1)))),
                        )
                      ],
                    ))
              ],
            ),
          ),
          ExpenseCard(),
        ],
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showForm(iconEntries);
        },
        backgroundColor: Color.fromARGB(255, 206, 242, 225),
        child: Icon(
          Icons.add,
          color: const Color(0xff1B8C42),
        ),
      ),
    );
  }

  void showForm(iconEntries) async {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        backgroundColor: Color(0xffCEF2E1),
        isScrollControlled: true,
        builder: (_) => Container(
              // decoration: const BoxDecoration(
              //   color: const Color(0xffCEF2E1),
              // ),
              // color: Color(0xffCEF2E1),#38734D,#169EF2
              // decoration: const BoxDecoration(gradient: LinearGradient(
              //         colors: [Color(0xff45BF86), Color(0xffCEF2E1)],
              //         begin: Alignment.bottomCenter,
              //         end: Alignment.topCenter)
              //     ),
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        hintText: 'What did you spend on ?',
                        border: OutlineInputBorder(),
                        //icon: Icon(Icons.edit)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Discription",
                        hintText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            readOnly: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              labelText: "Price",
                              hintText: 'Price',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownMenu<TypeLabel>(
                            initialSelection: TypeLabel.misc,
                            controller: typeController,
                            label: const Text('Type'),
                            dropdownMenuEntries: iconEntries,
                            onSelected: (TypeLabel? type) {
                              setState(() {
                                selectedtype = type;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal

                      await addItem();
                      // Clear the text fields
                      titleController.text = '';
                      descriptionController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create New'),
                  )
                ],
              ),
            ));
  }
}

enum TypeLabel {
  work('Work', Icons.add_business),
  shopping('Shopping', Icons.shopping_cart),
  health('Health', Icons.health_and_safety),
  techBills('Tech Bills', Icons.signal_cellular_connected_no_internet_0_bar),
  travel('travel', Icons.skateboarding),
  misc('Misc', Icons.money),
  ;

  const TypeLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
/*
type can be
  TYPE               icon name
Work      -    add bussiness ....looks like home
shopping  -    shopping cart
Health         -    sick
Tech bills-    signal cellular connected no internet
travel         -    scateboading/ surfing
Misc          -    monetisation

*/


// class Items {
//   static List<Map<String, dynamic>> items = [];
// }
// class Items {
//   final int id;
//   final String title;
//   final String disc;
//   final String type;
//   final int price;
//   final String day;
//   final String month;
//   final String year;

//   const Items({
//     required this.id,
//     required this.title,
//     required this.disc,
//     required this.price,
//     required this.day,
//     required this.month,
//     required this.year,
//     required this.type,
//   });
// }

// List<Items> itemdata = [
//   Items(
//       id: HomePage.items,
//       title: "example title",
//       disc: "example disc",
//       price: 500,
//       day: ,
//       month: ,
//       year: ,
//       type: "example type")
// ];
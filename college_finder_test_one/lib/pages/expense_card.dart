import 'package:college_finder_test_one/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:college_finder_test_one/database/dataase_helper.dart';

// ignore: must_be_immutable
class ExpenseCard extends StatefulWidget {
  // ExpenseCard({super.key});

// List<Map<String, dynamic>> items = [];
  ExpenseCard({super.key});

  @override
  State<ExpenseCard> createState() => ExpenseCardState();
}

class ExpenseCardState extends State<ExpenseCard> {
  void getAllItems() async {
    //gets all items and stores it in items
    final data = await SQLHelper.getItems();
    final totalSpentThisMonthData = await SQLHelper.getPriceThisMonth();
    final totalSpentTodayData = await SQLHelper.getPriceToday();
    HomePagestate.totalSpentThisMonthList = totalSpentThisMonthData;
    HomePagestate.totalSpentTodayList = totalSpentTodayData;

    HomePagestate.totalSpentTodayList.forEach((element) {
      var inString = element.values.toString();
      inString = inString.replaceAll(new RegExp(r'[#*)(@!,^&%.$\s]+'), "");
      HomePagestate.todaySpentInt += int.parse(inString);

      HomePagestate.totalSpentThisMonthList.forEach((element) {
        var inString = element.values.toString();
        inString = inString.replaceAll(new RegExp(r'[#*)(@!,^&%.$\s]+'), "");
        HomePagestate.totalSpentInt += int.parse(inString);
        setState(() {
          HomePagestate.items = data;
          HomePagestate.todaySpentInt;
          HomePagestate.isLoading = false;
          HomePagestate.totalSpentInt;
        });
      });
    });
    print(HomePagestate.items);
  }

  void deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    getAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        child: SafeArea(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: HomePagestate.items.length,
            itemBuilder: (context, i) => Column(
              children: <Widget>[
                const Divider(
                  //color: Color(0xff393C73),
                  height: 15.0,
                ),
                Dismissible(
                  key: UniqueKey(),
                  //background: Container(color: Colors.red),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      print("onDismissed setState .... before");
                      deleteItem(HomePagestate.items[i]["id"]);
                      print("onDismissed setState .... after");
                      // HomePagestate.items.removeAt(i);
                      //print("onDismissed setState removing items");
                    });
                  },
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    tileColor: const Color(0xff1B8C42),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: const Padding(
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Color(0xffCEF2E1),
                          size: 40,
                        )),
                    //tileColor: Color(0xffA75CF2),
                    // contentPadding: EdgeInsets.all(5),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          HomePagestate.items[i]["title"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffCEF2E1)),
                        ),
                        // Text(
                        //   dummyData[i].time,
                        //   style: const TextStyle(
                        //       color: Color(0xffCEF2E1), fontSize: 20.0),
                        // ),
                      ],
                    ),
                    subtitle: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        HomePagestate.items[i]["description"],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 36, 33, 33),
                            fontSize: 12.0),
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text("${HomePagestate.items[i]["price"]}/-",
                          style: const TextStyle(
                              color: Color(0xffCEF2E1), fontSize: 20.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  // void getAllItems() async {
  //   //gets all items and stores it in items
  //   final data = await SQLHelper.getItems();
  //   setState(() {
  //     HomePagestate.items = data;

  //     HomePagestate.isLoading = false;
  //   });
  //   print(HomePagestate.items);
  // }
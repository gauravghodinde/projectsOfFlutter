class ExpenseModel {
  final String title;
  final String disc;
  final int cost;
  final String type;
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
  ExpenseModel(
      {required this.title,
      required this.disc,
      required this.cost,
      required this.type});
}

class Dog {
  final int id;
  final String title;
  final String disc;
  final String type;
  final int price;
  final String day;
  final String month;
  final String year;

  const Dog({
    required this.id,
    required this.title,
    required this.disc,
    required this.type,
    required this.price,
    required this.day,
    required this.month,
    required this.year,
  });
}

List<ExpenseModel> dummyData = [
  ExpenseModel(
      title: "example title",
      disc: "example disc",
      cost: 500,
      type: "example type")
];

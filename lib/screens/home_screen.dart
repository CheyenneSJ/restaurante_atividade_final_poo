import 'package:flutter/material.dart';
import 'package:restaurante_atividade_final_poo/models/meal.dart';
import 'package:restaurante_atividade_final_poo/screens/order_screen.dart';

import 'widgets/meal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final customerEC = TextEditingController();
  static List<Meal> menu = [
    Meal(
      id: 1,
      name: 'Arroz Carreteiro',
      price: 15.5,
    ),
    Meal(
      id: 2,
      name: 'X-Salada',
      price: 8.0,
    ),
    Meal(
      id: 3,
      name: 'X-Tudo',
      price: 16.0,
    ),
    Meal(
      id: 4,
      name: 'Refrigerante',
      price: 4.0,
    ),
    Meal(
      id: 5,
      name: 'Pudim',
      price: 6.0,
    ),
  ];
  static List<Meal> cart = [];

  double totalCartPrice = 0.0;

  @override
  void initState() {
    cart.addAll(menu);
    super.initState();
  }

  void calculateCartPrice() {
    double sum = 0;
    for (var i = 0; i < cart.length; i++) {
      sum += cart.map((e) => e.quantity * e.price).toList()[i];
    }

    setState(() {
      totalCartPrice = sum;
    });
  }

  void remove(Meal meal) {
    if (meal.quantity > 0) {
      setState(() {
        meal.quantity--;
      });
    }
    calculateCartPrice();
  }

  void add(Meal meal) {
    setState(() {
      meal.quantity++;
    });
    calculateCartPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final meal = cart[index];

                  return MealCard(
                    meal: meal,
                    onAdd: () {
                      add(meal);
                      setState(() {});
                    },
                    onRemove: () {
                      remove(meal);
                      setState(() {});
                    },
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: customerEC,
                decoration: const InputDecoration(
                  label: Text('Cliente'),
                  hintText: 'João da Silva',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderScreen(
                              meals: cart,
                              customer: customerEC.text,
                              totalCartPrice: totalCartPrice,
                            )));
                  },
                  child: Text(
                    'Finalizar Pedido R\$ ${totalCartPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

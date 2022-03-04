import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pugex/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PokeApi'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub? pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  getColor(color) {
    switch (color) {
      case 'Grass':
        return Colors.green;
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Bug':
        return Colors.lightGreen;
      case 'Normal':
        return Colors.grey;
      case 'Electric':
        return Colors.yellow;
      case 'Poison':
        return Colors.purple;
      case 'Ground':
        return Colors.brown;
      case 'Fighting':
        return Colors.orange;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                  child: Row(
                children: [
                  Image.network(
                      'https://www.w3schools.com/howto/img_avatar.png',
                      width: 80),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text('Nicolás Alani',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left),
                        const Text('@userfakeprofile',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.left)
                      ],
                    ),
                  )
                ],
              )),
              decoration: const BoxDecoration(color: Colors.redAccent),
            ),
            const ListTile(
              leading: Icon(Icons.work),
              title: Text('Search'),
            ),
            const ListTile(
              leading: Icon(Icons.wallet_giftcard),
              title: Text('Types'),
            ),
            const ListTile(
              leading: Icon(Icons.safety_divider),
              title: Text('Info'),
            ),
            const ListTile(
              leading: Icon(Icons.hail),
              title: Text('About'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18, top: 10),
            child: InkWell(
              // ignore: avoid_print
              onTap: () => {print("Get a Job")},
              child: Badge(
                badgeColor: Colors.lightBlue,
                badgeContent: const Text(
                  "9",
                  style: TextStyle(color: Colors.white),
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          )
        ],
        title: Image.asset('assets/logos/pokelogo.png',
            fit: BoxFit.contain, height: 150),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      // ignore: prefer_const_constructors
      body: pokeHub == null
          ? Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/backgrounds/pokedex_front.jpg'))))
          : Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/backgrounds/cyber_net.jpg'))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: pokeHub!.pokemon!
                      .map((poke) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () => {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('You pressed' + poke.name.toString()),
                              ))
                            },
                            splashColor: getColor(poke.type!.first),
                            child: Card(
                              elevation: 2.8,
                              child: Column(
                                children: [
                                  Container(
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                poke.img.toString()))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("#" + poke.num.toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                poke.name.toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                const Radius
                                                                        .circular(
                                                                    20)),
                                                        color: getColor(
                                                            poke.type!.first)),
                                                    child: Text(
                                                      poke.type!.first
                                                          .toString(),
                                                      style: new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                const Radius
                                                                        .circular(
                                                                    20)),
                                                        color: getColor(
                                                            poke.type!.first)),
                                                    child: Text(
                                                      poke.type!.first
                                                          .toString(),
                                                      style: new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )))
                      .toList(),
                ),
              ),
            ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
        backgroundColor: Colors.red,
        onPressed: null,
      ),
    );
  }
}

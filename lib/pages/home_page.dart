import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:poke_dex/model/Poke.dart';
import 'package:poke_dex/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateHomePAge();
  }
}

class StateHomePAge extends State<HomePage> {
  Future<Poke> future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   future=getValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade300,
        title: Text("PokeDex"),
      ),
      body: home_body(),
    );
  }

  home_body() {
    return FutureBuilder(
        future: future,
        builder: (context, AsyncSnapshot<Poke> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.black,
              child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (contex)=> DetailPAge(poke: snapshot.data.pokemon[index])));
                      },
                        child: Hero(
                          tag: snapshot.data.pokemon[index].img,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            color: Colors.deepOrange.shade100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(child: FadeInImage.assetNetwork(placeholder: "assets/gif.gif", image:(snapshot.data.pokemon[index].img))),
                                Text(
                                  snapshot.data.pokemon[index].name,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                    );
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<Poke> getValues() async {
    String url =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    var response = await http.get(url);
    var jsonObject = json.decode(response.body);
    return Poke.fromJson(jsonObject);
  }
}

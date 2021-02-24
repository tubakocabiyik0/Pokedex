import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:poke_dex/model/Poke.dart';

class DetailPAge extends StatefulWidget {
  Pokemon poke;

  DetailPAge({this.poke});

  @override
  State<StatefulWidget> createState() {
    return StateDetail();
  }
}

class StateDetail extends State<DetailPAge> {
  Color dominantColor;
  PaletteGenerator paletteGenerator;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    findColor();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.poke.name),
        backgroundColor: dominantColor,
      ),
      body: detailBody(),
    );
  }

  detailBody() {
    return Container(
      color: dominantColor,
      child: Stack(children: [
        Positioned(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.1,
          width: MediaQuery
              .of(context)
              .size
              .width - 20,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.6,
          left: 10,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            elevation: 0,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.network(
            widget.poke.img,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            Center(
                child: Padding(
                  padding:
                  EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.16),
                  child: Text(
                    widget.poke.name,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                )),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Height : " + widget.poke.height,
                      style: TextStyle(fontSize: 18, color: Colors.black),),
                    SizedBox(height: 15),
                    Text("Weight : " + widget.poke.weight,
                      style: TextStyle(fontSize: 18, color: Colors.black),),
                    SizedBox(height: 15),
                    Text("Egg : " + widget.poke.egg,
                      style: TextStyle(fontSize: 18, color: Colors.black),),
                    SizedBox(height: 15),
                    Text("Candy : " + widget.poke.candy,
                      style: TextStyle(fontSize: 18, color: Colors.black),),
                    SizedBox(height: 15),
                    Text("Evolution  ", style: TextStyle(fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),),
                    widget.poke.nextEvolution != null ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      widget.poke.nextEvolution.map((e) =>
                          Chip(
                              backgroundColor: Colors.deepOrange.shade200,
                              label: Text(e.name))).toList(),
                    ) : Text("No Evulation"),
                  ],
                ),
              ),
            )
          ],
        )
      ]),
    );
  }

  findColor() {
    Future<PaletteGenerator> fpaletteGenerator = PaletteGenerator
        .fromImageProvider(NetworkImage(widget.poke.img));
    fpaletteGenerator.then((value) {
      paletteGenerator=value ;
      setState(() {
        dominantColor = paletteGenerator.vibrantColor.color;
      });
    });
  }
}

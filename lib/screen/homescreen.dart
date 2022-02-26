// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wisata/api/api_destinasi.dart';
import 'package:wisata/api/api_kategori.dart';
import 'package:wisata/widget/destinasi_kategori.dart';
import 'package:wisata/widget/list_destinasi.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List listKategori = [];

  @override
  void initState() {
    getKategori().then((data) {
      setState(() {
        listKategori = data;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pariwisata Banjarmasin"),
          backgroundColor: Colors.redAccent,
        ),

        // ignore: unnecessary_new
        drawer: new Drawer(
          child: FutureBuilder<List>(
            future: getKategori(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['nama']),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                destinasiKategori(listKategori[index]),
                          ));
                        },
                      );
                    });
              }
              return CircularProgressIndicator();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List>(
            future: getDestinasi(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  // ignore: unnecessary_new
                  ? new ListDestinasi(
                      listDestinasi: snapshot.data,
                    )
                  // ignore: unnecessary_new
                  : new Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}

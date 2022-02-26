// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wisata/widget/destinasi_detail.dart';

// ignore: camel_case_types
class destinasiKategori extends StatelessWidget {
  final Map kategori;

  destinasiKategori(this.kategori);

  Future<List> getDestinasiKategori() async {
    final id = kategori['id'];
    var response =
        await Dio().get('http://wisata.test/api/destinasi/kategori/${id}');
    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kategori['nama']),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List>(
        future: getDestinasiKategori(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DestinasiDetail(
                                    listDestinasi: snapshot.data,
                                    index: index,
                                  )));
                        },
                        child: new ListTile(
                          leading: Image.network(
                              "${snapshot.data[index]['photo']}",
                              width: 100,
                              fit: BoxFit.cover),
                          title: new Text(
                            "${snapshot.data[index]['nama']}",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

import 'dart:ui';

// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtual/main.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

     Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.white
            ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight

        )
      ),
    );
    return Stack(
      children: <Widget> [
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget> [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text ("Novidades"),
                centerTitle: true
              ),
            ),
      FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").
              orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  );
                else {
                  print(snapshot.data.documents.length);
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map(
                            (doc){
                      return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                    }
                    ).toList(),
                    children: snapshot.data.documents.map(
                        (doc){
                          return FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: doc.data["image"],
                              fit: BoxFit.cover,
                          );
                        }
                    ).toList(),


                  );


                }

              },
            )

          ],

        )

      ],

    );
  }
}

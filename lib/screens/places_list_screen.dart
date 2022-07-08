import 'package:flutter/material.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<GreatPlaces>(
            child: const Center(child: Text('Nenhum local cadastrado!')),
            builder: (context, greatPlaces, child) {
              if (greatPlaces.itemsCount == 0) {
                return child!;
              }
              return ListView.builder(
                itemCount: greatPlaces.itemsCount,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      greatPlaces.itemByIndex(index).image,
                    ),
                  ),
                  title: Text(greatPlaces.itemByIndex(index).title),
                  subtitle: Text(
                    greatPlaces.itemByIndex(index).location.address!,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.placeDetail,
                      arguments: greatPlaces.itemByIndex(index),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_app/models/route_model.dart';
import 'package:google_maps_app/ui/app_bar_list.dart';

class RouteListScreen extends StatelessWidget {
  final List<RouteModel> routes;
  final int expandedRouteId;
  const RouteListScreen({
    Key? key,
    required this.routes,
    required this.expandedRouteId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          final points = route.points;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ExpansionTile(
              key: ValueKey(route.id),
              initiallyExpanded: expandedRouteId == route.id,
              textColor: Colors.blueAccent,
              iconColor: Colors.blueAccent,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      route.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              leading: Image.asset(
                route.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              children: [
                ...points.map((point) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        title: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: point.imagePath != null
                                  ? Image.asset(
                                      point.imagePath!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.image_not_supported,
                                          size: 60, color: Colors.grey),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    point.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      'Lat: ${point.latitude}, Lng: ${point.longitude}'),
                                  if (point.description != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        point.description!,
                                        style: TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      point.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    if (point.imagePath != null)
                                      Image.asset(
                                        point.imagePath!,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Lat: ${point.latitude}, Lng: ${point.longitude}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    if (point.longDescription != null)
                                      Text(
                                        point.longDescription!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Zamknij modalne okno
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.blueAccent,
                                      ),
                                      child: const Text('Zamknij'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

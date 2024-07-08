import 'package:flutter/material.dart';
import 'package:public_transport/addlocation1.dart';
import 'package:public_transport/taxilocation.dart';

void main() {
  runApp(TaxiDirectoryApp());
}

class TaxiDirectoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Directory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaxiSearchPage(),
    );
  }
}

class TaxiSearchPage extends StatefulWidget {
  @override
  _TaxiSearchPageState createState() => _TaxiSearchPageState();
}

class _TaxiSearchPageState extends State<TaxiSearchPage> {
  final List<String> locations = ['City A', 'City B', 'City C'];
  String? fromLocation;
  String? toLocation;
  final List<Taxi> taxis= [];

  List<Taxi> filteredTaxi = [];
  
  get AddTaxi => null;

  void searchTaxis() {
    setState(() {
      filteredTaxi = taxis.where((taxi) {
        final fromMatch = fromLocation == null || taxi.from == fromLocation;
        final toMatch = toLocation == null || taxi.to == toLocation;
        return fromMatch && toMatch;
      }).toList();
    });
  }

  void addLocation(String location) {
    setState(() {
      locations.add(location);
    });
  }

  void addTaxi(Taxi taxi) {
    setState(() {
      taxis.add(taxi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxi Directory'),
      ),
      body: Container(
        color: Colors.lightBlue.shade50, // Set the background color here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: fromLocation,
              decoration: InputDecoration(
                labelText: 'From Location',
                prefixIcon: Icon(Icons.location_on),
              ),
              items: locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  fromLocation = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: toLocation,
              decoration: InputDecoration(
                labelText: 'To Location',
                prefixIcon: Icon(Icons.location_on),
              ),
              items: locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  toLocation = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: searchTaxis,
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocationPage(onAddLocation: addLocation),
                  ),
                );
              },
              icon: Icon(Icons.add_location),
              label: Text('Add Location'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaxiPage(
                      locations: locations,
                      onAddTaxi: AddTaxi,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.directions_car),
              label: Text('Add Taxi'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTaxi.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text(filteredTaxi[index].name),
                    subtitle: Text('${filteredTaxi[index].from} to ${filteredTaxi[index].to}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaxiDetailsPage(
                            taxiName: filteredTaxi[index].name,
                            fromLocation: filteredTaxi[index].from,
                            toLocation: filteredTaxi[index].to,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaxiDetailsPage extends StatelessWidget {
  final String taxiName;
  final String fromLocation;
  final String toLocation;

  TaxiDetailsPage({required this.taxiName, required this.fromLocation, required this.toLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taxiName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Taxi Name: $taxiName', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('From: $fromLocation', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('To: $toLocation', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class AddLocationPage extends StatefulWidget {
  final Function(String) onAddLocation;

  AddLocationPage({required this.onAddLocation});

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final TextEditingController locationController = TextEditingController();

  void addLocation() {
    final location = locationController.text;
    if (location.isNotEmpty) {
      widget.onAddLocation(location);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location Name',
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: addLocation,
              icon: Icon(Icons.add),
              label: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class Taxi {
  final String from;
  final String to;
  final String name;

  Taxi({required this.from, required this.to, required this.name});
}
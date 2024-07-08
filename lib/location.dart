import 'package:flutter/material.dart';
import 'package:public_transport/transport.dart';

void main() {
  runApp(BusScheduleApp());
}

class BusScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Schedule App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BusSchedulePage(),
    );
  }
}

class BusSchedule {
  final String busName;
  final String fromLocation;
  final String toLocation;
  final String startTime;
  final String endTime;

  BusSchedule(this.busName, this.fromLocation, this.toLocation, this.startTime, this.endTime);
}

class BusSchedulePage extends StatefulWidget {
  @override
  _BusSchedulePageState createState() => _BusSchedulePageState();
}

class _BusSchedulePageState extends State<BusSchedulePage> {
  final List<BusSchedule> schedules = [
    BusSchedule('Bus 1', 'Location A', 'Location B', '8:00 AM', '10:00 AM'),
    BusSchedule('Bus 2', 'Location B', 'Location C', '9:00 AM', '11:00 AM'),
    BusSchedule('Bus 3', 'Location A', 'Location C', '10:00 AM', '12:00 PM'),
    BusSchedule('Bus 4', 'Location C', 'Location D', '11:00 AM', '1:00 PM'),
    BusSchedule('Bus 5', 'Location D', 'Location A', '12:00 PM', '2:00 PM'),
  ];

  String fromLocation = '';
  String toLocation = '';

  @override
  Widget build(BuildContext context) {
    List<BusSchedule> filteredSchedules = schedules.where((schedule) {
      return (fromLocation.isEmpty || schedule.fromLocation.toLowerCase().contains(fromLocation.toLowerCase())) &&
             (toLocation.isEmpty || schedule.toLocation.toLowerCase().contains(toLocation.toLowerCase()));
    }).toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 44, 135, 141), // Set background color
      appBar: AppBar(
        title: Text('Bus Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'From',
                prefixIcon: Icon(Icons.location_on, color: Colors.white), // Add icon
              ),
              onChanged: (value) {
                setState(() {
                  fromLocation = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'To',
                prefixIcon: Icon(Icons.location_on, color: Colors.white), // Add icon
              ),
              onChanged: (value) {
                setState(() {
                  toLocation = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = filteredSchedules[index];
                  return Card(
                    child: ListTile(
                      title: Text(schedule.busName),
                      subtitle: Text('${schedule.fromLocation} to ${schedule.toLocation}\nFrom: ${schedule.startTime} - To: ${schedule.endTime}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusDetailsPage(busSchedule: schedule),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransportHomePage()),
                );
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

class BusDetailsPage extends StatelessWidget {
  final BusSchedule busSchedule;

  BusDetailsPage({required this.busSchedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(busSchedule.busName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${busSchedule.fromLocation}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('To: ${busSchedule.toLocation}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Start Time: ${busSchedule.startTime}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('End Time: ${busSchedule.endTime}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HumanStream extends StatefulWidget {
  static String screenId = "HumanList";

  @override
  State<HumanStream> createState() => _HumanStreamState();
}

class _HumanStreamState extends State<HumanStream> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final email;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final currentUser = await _auth.currentUser;
    email = currentUser?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set the background color to black
      appBar: AppBar(
        title: Text("Human Stream", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800], // Dark blue app bar
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection("people").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else {
            final people = snapshot.data!.docs;
            List<HumanCard> peopleCard = [];
            for (var person in people) {
              final personData = person.data() as Map<String, dynamic>;
              final personImage = personData["Gender"] == "Male"
                  ? "assets/images/Male.png"
                  : "assets/images/Female.png";
              final personName = personData["Name"];
              final personUni = personData["University"];
              final personMajor = personData["Major"];
              final personCreated = _auth.currentUser?.email;

              final humanCard = HumanCard(
                imageUrl: personImage,
                name: personName,
                university: personUni,
                major: personMajor,
                createdBy: personCreated ?? "Unknown", // Use "Unknown" if null
              );
              peopleCard.add(humanCard);
            }
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: peopleCard,
            );
          }
        },
      ),
    );
  }
}

class HumanCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String university;
  final String major;
  final String createdBy;

  const HumanCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.university,
    required this.major,
    required this.createdBy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.black, // Dark card background to match dark theme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for a smooth effect
      ),
      elevation: 5, // Add elevation for shadow effect
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60, // Adjust size as needed
              height: 60, // Adjust size as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Circular image
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover, // Ensures the image covers the container
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ], // Add shadow to image container for a more elegant look
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Light text color on dark background
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "University : $university",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70, // Lighter text for subtitle
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Major : $major",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70, // Lighter text for subtitle
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Created by: $createdBy',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]), // Subtle color for the "created by"
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

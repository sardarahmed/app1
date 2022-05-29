import 'package:app1/models/user_model.dart';
import 'package:app1/screens/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/data.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late TabController tabController;

  @override
  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());

      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fest in  the Nest"),
          backgroundColor: Colors.black,
          centerTitle: true,
          bottom: TabBar(controller: tabController, tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.event),
              text: "Events",
            ),
            Tab(
              icon: Icon(Icons.contact_page),
              text: "Contact Us",
            ),
          ]),
        ),
        body: Container(
            child: TabBarView(controller: tabController, children: [
          HomePage(),
          Events(),
          ContactUs(),
        ])));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/logo.jpg",
                height: 500,
                alignment: Alignment.center,
              ),
              Text(
                "Fest in the Nest",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                """Hosted in Eagle Nest, New Mexico - a town founded on rebellion, and infused with the edgy energy of the prohibition era - the first annual Fest In The Nest music festival and 40th annual 
    Memorial Day Motorcycle Rally promises an authentic rock and motorcycle experience that you won’t want to miss. 
    This high energy motorforward two day celebration will unite rock and motorcycle fans from across the country, in a place where delicious food, great drinks, and the exhilaration of motorcycles only pale in comparison to the epic high desert views . 
    
    """,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          )),
    );
  }
}

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Chad Mantz',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Phone Number: 800-453-3498',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Email',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'events@mvacationproperties.com',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Address',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '51 E Therma St, Eagle Nest, MN 87718',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class Events extends StatefulWidget {
  Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Widget UI(String photos, String heading, String subheading) {
    return Card(
      color: Colors.black,
      child: Column(
        children: [
          Image.network(photos),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              heading,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              subheading,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<String> photos = [
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890038/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Amped_Owl_Drive_zjlews.jpg",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890038/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Gilead_Rises_xv971g.jpg",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890144/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Pink_Freud_retnky.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890139/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Shistr_zlrejl.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890039/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Desert_Playboys_xofyh0.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890143/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/The_Timewreckers_aaq1di.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890138/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/The_Talking_Hours_o5e0tz.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890141/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Red_Mesa_a36z9u.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890145/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/The_Riddims_pjct1r.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890037/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Harles_bbzpqf.jpg",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890147/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Sorry_Guero_aivjoc.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890148/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Anesthesia_esiftf.png",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890038/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Ry_Taylor_r3rqf0.jpg",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890041/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Garry_Blackchild_xzvu0d.jpg",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890038/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Ry_Taylor_r3rqf0.jpg",
    "https://res.cloudinary.com/m-vacation-properties-resorts/image/upload/v1652890383/Fest%20in%20the%20Nest%20%7C%20Band%20Pictures/Fest_in_the_Nest_Announcement_udf6xe.png"
  ];
  List<String> heading = [
    "Amped Owl Drive",
    "Gilead Rises",
    "Pink Freud",
    "Shistr",
    "Desert Playboys",
    "The Timewreckers",
    "The Talking Hours",
    "Red Mesa",
    "The Riddims",
    "Hart-less",
    "Sorry Guero",
    "Anesthesia ",
    "Black Sabbitch",
    "Gary Blackchild",
    "Ry Taylor",
    "Bike Show"
  ];
  List<String> subheading = [
    "May 27, 2022 | 06:00pm- 10:00pm",
    "May 27, 2022 | 06:00pm - 10:00pm",
    "May 27, 2022 | 06:00pm - 10:00pm",
    "May 27, 2022 | 06:00pm - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 11:00am - 10:00pm",
    "May 28, 2022 | 3:00pm-5:00pm"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        color: Colors.black,
        child: new ListView.builder(
            itemCount: photos.length,
            itemBuilder: (_, index) {
              return UI(photos[index], heading[index], subheading[index]);
            }));
  }
}

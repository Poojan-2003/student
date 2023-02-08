import 'package:flutter/material.dart';
import 'package:student/profile_page.dart';
import 'Previous_data.dart';
import 'main_homePage.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

   TabController ? tabController;

   int selectedIndex=0;

   onItemClicked(int index){
     setState(() {
       selectedIndex = index;
       tabController!.index = selectedIndex;
     });
   }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

  }
   double screenWidth= 0;
   double screenHeigth = 0;
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          MainHomePage(),
          PreviousDATA(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined),label:"Uploads"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile")

        ],

        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
        selectedLabelStyle: TextStyle(fontSize: 14),

      ),
    );

  }
}


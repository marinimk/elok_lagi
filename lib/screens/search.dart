import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Widget buildSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.black87,
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.chevron_right_sharp),
            onPressed: () => {
              print("marini mk"),
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        // color: Colors.purple,
        child: buildSearch(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/glass.png'),
          ),
        ),
        // child: Text(
        //   "Search page find me bitch",
        //   style: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
    );
  }
}

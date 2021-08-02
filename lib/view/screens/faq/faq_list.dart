import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/faq.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/faq/faq_data.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class FAQList extends StatefulWidget {
  @override
  _FAQListState createState() => _FAQListState();
}

class _FAQListState extends State<FAQList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<List<FAQ>>(
      stream: DatabaseService(uid: user.uid).faqList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FAQ> faq = snapshot.data;
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(5),
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: faq.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: FAQData(faqid: faq[index].faqid)));
                  },
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 3, color: colorsConstBrown[400]),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(faq[index].question,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SubmitFeedback extends StatefulWidget {
  final String ruid;
  final String fid;
  SubmitFeedback({this.ruid, this.fid});
  @override
  SubmitFeedbackState createState() => SubmitFeedbackState();
}

class SubmitFeedbackState extends State<SubmitFeedback> {
  final _formKey = GlobalKey<FormState>();

  String _feedback;
  int _rating;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (val) => val.isEmpty
                    ? 'please field in your new $widget.title.toLowerCase()'
                    : '',
                onChanged: (val) => setState(
                      () => _feedback = val,
                    ),
                decoration:
                    textInputDecoration(Icons.border_color, 'Feedback')),
          ),
          SizedBox(height: 5),
          RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Icon(Icons.sentiment_very_dissatisfied,
                      color: Colors.red);
                case 1:
                  return Icon(Icons.sentiment_dissatisfied,
                      color: Colors.redAccent);
                case 2:
                  return Icon(Icons.sentiment_neutral, color: Colors.amber);
                case 3:
                  return Icon(Icons.sentiment_satisfied,
                      color: Colors.lightGreen);
                case 4:
                  return Icon(Icons.sentiment_very_satisfied,
                      color: Colors.green);
                default:
                  return Container();
              }
            },
            onRatingUpdate: (value) => _rating = value.toInt(),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: buttonTextRow(Icons.check_circle, 'Submit'),
                style: elevatedButtonStyle().copyWith(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () async {
                  await DatabaseService(
                          uid: user.uid, ruid: widget.ruid, fid: widget.fid)
                      .submitFeedback(_feedback, _rating);
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: buttonTextRow(Icons.cancel, 'Cancel'),
                style: elevatedButtonStyle().copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

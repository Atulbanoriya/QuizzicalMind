import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color(0xff40E0D0),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Stack(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      'image/dailog.png', // Replace with your image path
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                      color: Colors.white,// Make image take full width
                    ),
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: onCancel,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: onConfirm,
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

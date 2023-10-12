

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardBody extends StatelessWidget {
  const CardBody({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal:20),
      child: Container(
        height: 80,
        width: double.infinity,
        // margin: const EdgeInsets.only(bottom: 10),
        decoration:  BoxDecoration(
          color: const Color(0xfffdf2f9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                    'Nguyen Van A',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),

                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
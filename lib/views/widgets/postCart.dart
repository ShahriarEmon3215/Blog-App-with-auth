import 'package:flutter/material.dart';

Widget postCard(String? imgUrl, title, userID, postedAt) {
  return Container(
    padding: EdgeInsets.all(8.0),
    height: 150,
    child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              height: 130,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    bottomLeft: Radius.circular(22)),
                child: Image.network(
                  imgUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.length > 40
                            ? '${title!.substring(0, 35)}...'
                            : title!,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text("Author: ${userID!}"),
                      Text("Posted at: ${postedAt!}"),
                    ]),
              ),
            ),
          ],
        )),
  );
}

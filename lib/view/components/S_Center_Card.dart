import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScCard extends StatelessWidget {
  final String name, image, services, location;

  ScCard(this.name, this.image, this.services, this.location);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    color: Colors.grey,
                    child: Icon(
                      Icons.image_rounded,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    child: Icon(
                      Icons.broken_image_rounded,
                      color: Colors.white,
                    ),
                  ),
                  imageUrl: image,
                  height: 80,
                  width: 120,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.build_rounded,
                        color: Colors.grey,
                        size: 14,
                      ),
                      Text(
                        ' ' + services,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.grey,
                        size: 14,
                      ),
                      Text(' ' + location,
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
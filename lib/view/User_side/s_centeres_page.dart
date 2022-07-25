import 'package:bike_service_app/view/components/S_Center_Card.dart';
import 'package:flutter/cupertino.dart';

class ServicesPage extends StatelessWidget {
  List<Map> serviceCenteres = [
    {
      'name': 'ABC Car Zone',
      'image': 'https://www.marutisuzuki.com/images/appointment-bg-mob.jpg',
      'services': 'Casr Wash, Stickering',
      'location': 'Khawerpur, Agartala'
    },
    {
      'name': 'DB Evolution',
      'image':
          'https://autoshifts.com/wp-content/uploads/2021/04/8ec8c5abed7251b57876cb6fdc52df41-1024x684.jpg',
      'services': 'Stickering, Washing',
      'location': 'Melarmath, Agartala'
    },
    {
      'name': 'Motor Hub',
      'image':
          'https://cdni.autocarindia.com/ExtraImages/20171122115622_1--Main-Image-copy.jpg',
      'services': 'Bike/Card Reparing, Accessories',
      'location': 'Motorstand, Agartala'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: serviceCenteres.length,
        itemBuilder: ((context, int index) {
          return ScCard(
              serviceCenteres[index]['name'],
              serviceCenteres[index]['image'],
              serviceCenteres[index]['services'],
              serviceCenteres[index]['location']);
        }));
  }
}

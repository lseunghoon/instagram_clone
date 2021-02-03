import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/avatar.dart';
import 'package:instagram_clone/widgets/common_size.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<bool> followings = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                setState(() {
                  followings[index] = !followings[index];
                });
              },
              leading: Avatar(),
              title: Text('username $index'),
              subtitle: Text('user bio number $index'),
              trailing: Container(
                alignment: Alignment.center,
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: followings[index] ? Colors.red[50] : Colors.blue[50],
                  border: Border.all(
                      color: followings[index] ? Colors.red : Colors.blue,
                      width: 0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'following',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey);
          },
          itemCount: followings.length),
    );
  }
}

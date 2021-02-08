import 'package:cloud_firestore/cloud_firestore.dart';

class UserNetworkRepository {
  //data 넣기
  Future<void> sendData() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc('123123123')
        .set({'email': 'testing@gmail.com', 'username': 'myusername'});
  }

  //data 가져오기
  void getData() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc('123123123')
        .get()
        .then((docSnapshot) => print(docSnapshot.data()));
  }
}

//다른 파일에서 쓸 수 있도록 내보기
UserNetworkRepository userNetworkRepository = UserNetworkRepository();

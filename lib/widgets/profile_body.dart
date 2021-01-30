import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';
import 'package:instagram_clone/constants/screen_size.dart';
import 'package:instagram_clone/widgets/avatar.dart';
import 'package:instagram_clone/widgets/common_size.dart';

class ProfileBody extends StatefulWidget {
  final Function() onMenuChanged;

  const ProfileBody({Key key, this.onMenuChanged}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.left;

  double _leftImagesMargin = 0;
  double _rightImagesMargin = size.width;

  AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController =
        AnimationController(vsync: this, duration: duration);
    super.initState();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _appbar(),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(common_gap),
                        child: Row(
                          children: <Widget>[
                            Avatar(
                              size: 80.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: common_gap),
                                child: Table(
                                  children: [
                                    TableRow(
                                      children: [
                                        _valueText('ㄴㄴㅇㄹㄴ'),
                                        _valueText('ㄴㅇㄹㄴ'),
                                        _valueText('ㄴㅇㅉㅈㄴㄴ'),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _labelText('Post'),
                                        _labelText('Followers'),
                                        _labelText('Following'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _username(),
                      _userBio(),
                      _editProfileBtn(),
                      _tabButtons(),
                      _selectedIndicator(),
                    ],
                  ),
                ),
                _imagesPager()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 44.0,
        ),
        Expanded(
          child: Text(
            'Profile title',
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _iconAnimationController,
          ),
          onPressed: () {
            widget.onMenuChanged();
            _iconAnimationController.status == AnimationStatus.completed
                ? _iconAnimationController.reverse()
                : _iconAnimationController.forward();
          },
        ),
      ],
    );
  }

  Text _valueText(String value) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _labelText(String value) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 11,
      ),
    );
  }

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_leftImagesMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_rightImagesMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
        ],
      ),
    );
  }

  GridView _images() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "http://picsum.photos/id/$index/100/100"),
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      duration: duration,
      curve: Curves.fastOutSlowIn,
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
    );
  }

  Row _tabButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconButton(
              icon: ImageIcon(
                AssetImage('assets/images/grid.png'),
                color: _selectedTab == SelectedTab.left
                    ? Colors.black
                    : Colors.black26,
              ),
              onPressed: () {
                _tabSelected(SelectedTab.left);
              }),
        ),
        Expanded(
          child: IconButton(
              icon: ImageIcon(
                AssetImage('assets/images/saved.png'),
                color: _selectedTab == SelectedTab.left
                    ? Colors.black26
                    : Colors.black,
              ),
              onPressed: () {
                _tabSelected(SelectedTab.right);
              }),
        )
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImagesMargin = 0;
          _rightImagesMargin = size.width;
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagesMargin = -size.width;
          _rightImagesMargin = 0;
          break;
      }
    });
  }
}

Padding _editProfileBtn() {
  return Padding(
    padding:
        EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
    child: SizedBox(
      height: 24.0,
      child: OutlineButton(
        child: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
        borderSide: BorderSide(
          color: Colors.black45,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    ),
  );
}

Widget _username() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      'username',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget _userBio() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      'this is userbio',
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}

enum SelectedTab { left, right }

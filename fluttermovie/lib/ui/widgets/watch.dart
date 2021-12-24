import 'package:flutter/material.dart';
import 'package:fluttermovie/ui/screens/screens.dart';

class watch extends StatelessWidget {
  final String imgUrl;

  const watch({Key? key, required this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 55,
            left: 0,
            right: 0,
            top: 0,
            child: ClipPath(
              clipper: CustomClip(),
              child: Image.network(
                "$imgUrl",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              color:
                  Colors.black.withOpacity(0.4), //khung chứa tmdb đã bị làm mờ
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "TMDB",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark_add_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            // child: InkWell(
            // onTap: () {
            //   // Navigator.pushNamed(context, VideoApp.route);
            // },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 3.0,
                      offset: Offset(0, 1)),
                ],
              ),
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.not_started_outlined,
                color: Colors.red,
              ),
            ),
          ),
          // ),
          Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {},
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClip oldClipper) {
    return true;
  }
}
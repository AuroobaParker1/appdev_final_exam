import 'package:flutter/material.dart';

class RecommendedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            child: const Padding(
              padding: EdgeInsets.only(top: 30, left: 8, right: 16, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Recommended for your Devices',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.blueGrey[800],
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, right: 16),
                        child: Icon(Icons.bookmark_outline,
                            color: Colors.blue, size: 30),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 16, left: 8, right: 16, bottom: 16)),
                    Center(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          Image.asset(
                            'assets/headphones.png',
                            width: 400,
                            height: 400,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Free Engraving',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'AirPods Max - Silver',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'A\$899.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.green,
                                ),
                                SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.blue,
                                ),
                                SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.yellow,
                                ),
                                Text(
                                  '   + 1 more',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

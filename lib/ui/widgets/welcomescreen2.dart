import 'package:flutter/material.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/views/home.dart';

class WelcomeScreen2 extends StatefulWidget {
  @override
  _WelcomeScreen2State createState() => _WelcomeScreen2State();
}

class _WelcomeScreen2State extends State<WelcomeScreen2> {

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.1, 0.4, 0.7, 0.9],
      colors: [
        Color(0xFF3594DD),
        Color(0xFF4563DB),
        Color(0xFF5036D5),
        Color(0xFF5B16D0),
      ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: () {Navigator.of(context).pushReplacement(
        MaterialPageRoute(
                builder: (context) => HomeDashboardScreen(),
              )
            );
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Container(
          height: 500,
          child: PageView(
            physics: ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image(
                        image: AssetImage(
                          'assets/images/ledgers.png',
                        ),
                        height: 280.0,
                        width: 280.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'View parties, products,\nand vouchers.',
                      style: secondaryListTitle.copyWith(color: TassistWhite),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'View all your parties, latest vouchers, and products on the app itself.',
                      style: secondaryListDisc.copyWith(color: TassistWhite),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: ClipRect(
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Image(
                          image: AssetImage(
                            'assets/images/invoice-maker.png',
                          ),
                          height: 280.0,
                          width: 280.0,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Make GST invoices\nfrom the app!',
                        style: secondaryListTitle.copyWith(color: TassistWhite),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Select from parties & products from Tally to create new invoices from TallyAssist.',
                        style: secondaryListDisc.copyWith(color: TassistWhite),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image(
                        image: AssetImage(
                          'assets/images/invoice.png',
                        ),
                        height: 280.0,
                        width: 280.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Generate inovices and\nparty statements',
                      style: secondaryListTitle.copyWith(color: TassistWhite)
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Generate pdfs and share with your customers via WhatsApp & email.',
                      style: secondaryListDisc.copyWith(color: TassistWhite),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        _currentPage != _numPages - 1
            ? Expanded(
              flex: 1,
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Text(''),
      ],
            ),
          ),
        ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 70.0,
              width: double.infinity,
              color: TassistMenuBg,
              child: GestureDetector(
                onTap:  () {Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                      builder: (context) => HomeDashboardScreen(),
                    )
          );
                }, 
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: TassistWhite,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}






  
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 10), () {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => HomeDashboardScreen()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: TassistPrimary,
//           child: Stack(
//             fit: StackFit.expand,
//             children: <Widget>[
//               // Image(
//               //   image: AssetImage('graphics/dataanalysis.png'),
//               //   fit: BoxFit.fill,
//               // ),
//               Padding(
//                 padding: spacer.all.md,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                      Text(
//                   'Welcome to TallyAssist!',
//                   style: Theme.of(context)
//                   .textTheme
//                   .headline6
//                   .copyWith(fontSize: 24.0, color: TassistWhite),
//                 ),
//                 SizedBox(height: 50),
//                 Text(
//                   'Have you installed the Tally Connector yet?',
//                   style: Theme.of(context)
//                   .textTheme
//                   .headline6
//                   .copyWith(fontSize: 20.0, color: TassistWhite),
//                 ),
//                 SizedBox(height: 30),
//                  RaisedButton( 
//                    color: TassistWhite,
//                    child:
//                    Row(children: <Widget>[
//                   Icon(FontAwesomeIcons.laptop),
//                   SizedBox(width: 30),
//                   Text('Launch the Tally Connector website')

//                    ]),
//                 onPressed: () => _launchURL(),)
       

//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// _launchURL() async {
//   const url = 'https://restat.co/tallyassist/';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({Key? key}) : super(key: key);

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to RBAC', style: TextStyle(fontSize: 18)),
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF5367EC),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/security.jpg',
                  height: 400,
                  width: 400,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: SizedBox(
                    width: 340,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/signin',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: const Color(0xFF5367EC),
                      ),
                      child: const Text('SIGNIN'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    width: 340,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/signup',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: Colors.grey[200],
                        foregroundColor: const Color(0xFF5367EC),
                      ),
                      child: const Text('SIGNUP'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:dicoding_final_project/ui/ProfileScreen.dart';
import 'package:dicoding_final_project/ui/home.dart';
import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMovieList',
      // theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
      // initialRoute: Index.routeName,
      routes: {
        HomeScreen.routeName: (context)=>const HomeScreen(),
        ProfileScreen.routeName: (context)=>const ProfileScreen(),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int currentPageIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProfileScreen(),
  ];

  // Bottom Navigation With NavigationBar Widget
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     extendBody: true,
  //     body: Center(
  //       child: _widgetOptions.elementAt(currentPageIndex),
  //     ),
  //     bottomNavigationBar: NavigationBar(
  //       destinations: const[
  //         NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
  //         NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
  //         NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
  //       ],
  //       selectedIndex: currentPageIndex,
  //       onDestinationSelected: (int index){
  //         setState((){
  //           currentPageIndex = index;
  //         });
  //       },
  //       animationDuration: const Duration(milliseconds: 500),
  //     ),
  //   );
  // }

  // Bottom Navigation with BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("IDLIX2"),
        leading: IconButton(
          icon: const Icon(Icons.movie_creation_outlined),
          onPressed: () => (){},
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child:Container(
            child: _widgetOptions.elementAt(currentPageIndex),
          ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          items: const<BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: currentPageIndex,
          onTap: (int index){
            setState((){
              currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
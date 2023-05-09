import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../color_schemes.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ProfileScreen",
      // theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
        decoration:const BoxDecoration(
          // color: Theme.of(context).primaryColor
          gradient: LinearGradient(
              colors: [
                Color(0xFF0e1c26),
                Color(0xFF2a454b),
                Color(0xFF294861),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    const CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage("https://picsum.photos/id/237/200/300")
                    ),
                    Text(
                      "Antonio Christopher (21)",
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,

                    ),
                    Text(
                      "Institut Sains dan Teknologi Terpadu Surabaya",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,

                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding:  const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    "Sedikit tentang Aplikasi :\n1. Search Response di home bersifat responsive\n2. Search Response bisa diklik untuk menuju ke MovieDetail\n3. Movie Detail juga bersifat responsive\n4. lebih baik run dibrowser",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding:  const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child:Text(
                          "Connect with Me!",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          FilledButton(
                            onPressed: () {
                              _launch(Uri.parse("https://github.com/AntonioCR11"));
                            },
                            child: const Text("Github"),
                          ),
                          FilledButton(
                            onPressed: () {
                              _launch(Uri.parse("https://www.linkedin.com/in/antonio-christopher-6ba341159/"));
                            },
                            child: const Text('LinkedIn'),
                          ),
                          FilledButton(
                            onPressed: () {
                              _launch(Uri.parse("https://www.instagram.com/anton_io11/"));
                            },
                            child: const Text('Instagram'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Container(
                padding:  const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child:Text(
                        "Yok Jangan kerja terus, capek! Nih ada Link Penyemangat :)",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        FilledButton(
                          onPressed: () {
                            _launch(Uri.parse("https://www.instagram.com/p/CpzzSq5t74v/"));
                          },
                          child: const Text('Penyemangat1'),
                        ),
                        FilledButton(
                          onPressed: () {
                            _launch(Uri.parse("https://www.instagram.com/p/Cqp9RyOMbGV/"));
                          },
                          child: const Text('Penyemangat2'),
                        ),
                        FilledButton(
                          onPressed: () {
                            _launch(Uri.parse("https://www.instagram.com/p/Cq19HvEgkVD/"));
                          },
                          child: const Text('Penyemangat3'),
                        ),
                      ],
                    )
                  ],
                ),
              )



            ],
          ),
        )
      ),
    );
  }
}

Future<void> _launch(Uri url) async {
  await canLaunchUrl(url)
      ? await launchUrl(url)
      : debugPrint("Cant Open Link!");
}
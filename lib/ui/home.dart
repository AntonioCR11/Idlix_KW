import 'package:dicoding_final_project/models/TitleResponse.dart';
import 'package:dicoding_final_project/ui/MovieDetailScreen.dart';
import 'package:flutter/material.dart';
import '../color_schemes.g.dart';

class HomeScreen extends StatelessWidget{
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HomeScreen",
      // theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: const HomeStatefulWidget(),
    );
  }

}

class HomeStatefulWidget extends StatefulWidget {
  const HomeStatefulWidget({super.key});

  @override
  State<HomeStatefulWidget> createState() => _HomeStatefulWidgetState();
}

class _HomeStatefulWidgetState extends State<HomeStatefulWidget> {
  String searchedTitle = "";
  final TextEditingController searchController = TextEditingController();
  late FutureBuilder<TitleResponse> titleResponse;
  late Widget movieContainer;
  late String promoText;
  late String promoTextExpanded;

  @override
  void initState() {
    super.initState();
    titleResponse = FutureBuilder<TitleResponse>(
        future: fetchMovieByTitle(searchedTitle),
        builder: (context, snapshot) {
          return const Text("");
        }
    );
    promoText = "Responsive Layout Search Response! Our movie search feature allows you to easily find the perfect movie to watch. Simply enter a title and let our search engine do the work for you. With access to thousands of titles, you're sure to find something you'll love. Try it out today!";
    promoTextExpanded = "Looking for the perfect movie to watch can be time-consuming and frustrating. But with our movie search feature, you can easily find the film you're looking for. Whether you want to watch a classic, a blockbuster hit, or an indie gem, our search engine has you covered. With access to a vast library of titles, you'll never run out of options. Start your movie search today and enjoy endless hours of entertainment!";
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchMovie(){
    setState(() {
      searchedTitle = searchController.text;
      if(searchedTitle.isNotEmpty){
        titleResponse = FutureBuilder<TitleResponse>(
            future: fetchMovieByTitle(searchedTitle),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (snapshot.hasData &&  snapshot.connectionState == ConnectionState.done) {
                var listTitleResult = snapshot.data?.results as List<TitleResults>;

                if(listTitleResult.isEmpty){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close),
                      Text("Movie not found!",style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  );
                }
                // RETURN DATA
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 600) {
                      return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: _generateContainers(context,listTitleResult)
                      );
                    } else if (constraints.maxWidth < 900) {
                      return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children:  _generateContainers(context,listTitleResult),
                      );
                    } else {
                      return GridView.count(
                        crossAxisCount: 6,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: _generateContainers(context,listTitleResult),
                      );
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
      decoration:const BoxDecoration(
        // color: Theme.of(context).primaryColor
        gradient: LinearGradient(
            colors: [
              Color(0xFFef745c),
              Color(0xFF34073d)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: LayoutBuilder(
                builder: (BuildContext context,BoxConstraints constraints){
                  if(constraints.maxWidth < 600){
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome to IDLIX2",
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            promoText,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    searchMovie();
                                  },
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () => searchController.clear(),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Movie',
                              ),
                            ),
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: (){
                                searchMovie();
                              },
                              child: const Text('Search'),
                            ),
                          )
                        ],
                      ),
                    ) ;
                  }else{
                    return SingleChildScrollView(
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    mainAxisAlignment : MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Welcome to IDLIX2",
                                        style: Theme.of(context).textTheme.headlineMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        promoTextExpanded,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                    mainAxisAlignment : MainAxisAlignment.center,
                                    children: [
                                      TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          prefixIcon: IconButton(
                                            icon: Icon(Icons.search),
                                            onPressed: () {
                                              searchMovie();
                                            },
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: () => searchController.clear(),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          labelText: 'Movie',
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          onPressed: (){
                                            searchMovie();
                                          },
                                          child: const Text('Search'),
                                        ),
                                      )
                                    ]
                                ),
                              )
                          )
                        ],
                      ),
                    );
                  }
                }
            ),
          ),
          Expanded(
            flex: 6,
              child: titleResponse
          ),
        ],
      )
    );
  }
}

List<Widget> _generateContainers(context,List<TitleResults> titleResults) {
  if(titleResults.isEmpty){
    return [];
  }
  return List<Widget>.generate(titleResults.length, (index) {
    return buildItem(context, titleResults[index]);
  });
}

Widget buildItem(BuildContext context, TitleResults titleResults) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: Colors.black26,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: SizedBox(
            width: constraints.maxWidth/2,
            child: Text(
              titleResults.title.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: IconButton(onPressed: ()=>{}, icon: const Icon(Icons.favorite_border_outlined)),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieDetailScreen(titleResults: titleResults)),
            );
            // Navigator.pushNamed(context, MovieDetailScreen.routeName,arguments: titleResults);
          },
        );
      },
    )
  );
}
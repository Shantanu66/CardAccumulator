import 'package:flutter/material.dart';
import 'package:card_accumulator/splashscreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  final HttpLink link =
      HttpLink('https://card-accumulator-app.herokuapp.com/graphQL');
  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key? key,  required this.client}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Card Accumulator',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(
                color: Colors.black87,
              )),
          home: MySplash(),
        ),
      ),
    );
  }
}

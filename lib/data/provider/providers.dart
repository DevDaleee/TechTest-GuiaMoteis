import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:techtest_guia_motel/data/provider/home_page_provider.dart';

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider(
      create: (context) => HomePageProvider(),
    )
  ];
}

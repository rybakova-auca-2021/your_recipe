import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../features/grocery/domain/entities/grocery_item_response_entity.dart';

Future<void> exportAndShareGroceries(List<GroceryItemResponseEntity> groceries) async {
  List<List<String>> rows = [
    ["Name", "Quantity"],
    ...groceries.map((item) => [item.name, item.quantity.toString()])
  ];

  String csvData = const ListToCsvConverter().convert(rows);
  final directory = await getTemporaryDirectory();
  final path = "${directory.path}/grocery_list.csv";
  final file = File(path);

  await file.writeAsString(csvData);

  await Share.shareXFiles([XFile(file.path)]);
}

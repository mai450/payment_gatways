import 'item.dart';

class ListItemsModel {
  List<Item>? items;

  ListItemsModel({this.items});

  factory ListItemsModel.fromJson(Map<String, dynamic> json) {
    return ListItemsModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
      };
}

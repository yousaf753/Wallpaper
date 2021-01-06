import 'package:flutter/material.dart';

class Category {
  String name;
  AssetImage image;

  Category({
    @required this.name,
    @required this.image,
  });
}

List<Category> categoryList = [
  Category(
    image: AssetImage("image/abstract.jpg"),
    name: "Abstract",
  ),
  Category(
    image: AssetImage("image/animal.jpg"),
    name: "Animals",
  ),
  Category(
    image: AssetImage("image/art.jpg"),
    name: "Art",
  ),
  Category(
    image: AssetImage("image/building.jpg"),
    name: "Buildings",
  ),
  Category(
    image: AssetImage("image/nature.jpg"),
    name: "Nature",
  ),
  Category(
    image: AssetImage("image/car.jpg"),
    name: "Car",
  ),
  Category(
    image: AssetImage("image/city.jpg"),
    name: "City",
  ),
  Category(
    image: AssetImage("image/cricket.jpg"),
    name: "Cricket",
  ),
  Category(
    image: AssetImage("image/footbal.jpg"),
    name: "Footbal",
  ),
  Category(
    image: AssetImage("image/hockey.jpg"),
    name: "Hockey",
  ),
  Category(
    image: AssetImage("image/minimalist.jpg"),
    name: "Minimalist",
  ),
  Category(
    image: AssetImage("image/space.jpg"),
    name: "Space",
  ),
];

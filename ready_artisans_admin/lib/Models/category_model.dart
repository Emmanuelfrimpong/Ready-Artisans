// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../global_functions.dart';

class CategoryModel {
  String? name;
  String? image;
  String? description;
  String? id;

  CategoryModel({this.name, this.image, this.description, this.id});

  static List<CategoryModel> dummyData = [
    CategoryModel(
      name: 'Building & Construction',
      image:
          'https://majuba.edu.za/wp-content/uploads/2018/12/majuba-civil-4.jpg',
      description: 'Any building or construction related services',
    ),
    CategoryModel(
      name: 'Cleaning & Laundry',
      image:
          'https://cf.ltkcdn.net/cleaning/images/std/257114-800x515r1-how-properly-do-laundry.webp',
      description: 'Any cleaning or laundry related services',
    ),
    CategoryModel(
      name: 'Electrical & Electronics',
      image:
          'https://www.iit.edu.ng/storage/Pictures%20/Programmes/Electrotechncis%201.png',
      description: 'Any electrical or electronics related services',
    ),
    CategoryModel(
      name: 'Mechanics & Auto',
      image:
          'https://res.cloudinary.com/hkf2ycaep/image/fetch/d_project-placeholder.png,f_auto,fl_lossy/https://d23vk1trp0fmbf.cloudfront.net/projects/44b55e8a-e7c8-404c-be4e-caf1c97c5d5b/project-image',
      description: 'Any mechanics or auto related services',
    ),
    CategoryModel(
      name: 'Plumbing & Water',
      image:
          'https://media.istockphoto.com/id/665043432/photo/plumber-repairing-a-sink.jpg?s=612x612&w=0&k=20&c=rRfckKtMkg8Xn49oUPOzdafqC8r9ObOfelstMbjgsfQ=',
      description: 'Any plumbing or water related services',
    ),
    CategoryModel(
      name: 'Woodwork & Carpentry',
      image:
          'https://www.familyhandyman.com/wp-content/uploads/2022/10/GettyImages-1391067760.jpg?resize=700,467',
      description: 'Any woodwork or carpentry related services',
    ),
    CategoryModel(
      name: 'Painting & Decoration',
      image:
          'https://tradesmencosts.co.uk/wp-content/uploads/2020/05/painter-decorator-working.jpg',
      description: 'Any painting or decoration related services',
    ),
    CategoryModel(
      name: 'Gardening & Landscaping',
      image:
          'https://www.neponset.org/wp-content/uploads/2019/01/black-man-garden_landscape-1024x683.jpg',
      description: 'Any gardening or landscaping related services',
    ),
    CategoryModel(
      name: 'Furniture & Fixtures',
      image:
          'https://www.ghanaskills.org/sites/default/files/inline-images/Rwanda-DED-Dirk-Gebhardt-147%20Furniture%20Work.jpg',
      description: 'Any furniture or fixtures related services',
    ),
    CategoryModel(
      name: 'Fashion & Beauty',
      image:
          'https://ghanainsider.com/wp-content/uploads/2020/04/1578510803_maxresdefault.webp',
      description: 'Any fashion or beauty related services',
    ),
  ];

  CategoryModel copyWith({
    String? name,
    String? image,
    String? description,
    String? id,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': toTitleCase(name!),
      'image': image,
      'description': description,
      'id': id,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Categories(name: $name, image: $image, description: $description, id: $id)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        other.description == description &&
        other.id == id;
  }

  @override
  int get hashCode =>
      name.hashCode ^ image.hashCode ^ description.hashCode ^ id.hashCode;
}


class Mit{
  String? studentName;
  int? rollNo;
  Mit({required this.studentName,required this.rollNo});
  factory Mit.fromJson(Map<String,dynamic> parseJson){
    return Mit(
        studentName: parseJson['student_name'],
        rollNo: parseJson['student_rollNo']
    );
  }

}
class Images{
  int? id;
  String? image;
  Images({required this.id,required this.image});
  factory Images.fromJson(Map<String, dynamic> parseJson){
    return Images(
    id: parseJson['id'],
    image: parseJson['image_name'],
  );
  }

}

class Attributes{
  double? hieght;
  String?color;
  Attributes({required this.hieght,required this.color});

  factory Attributes.fromJson(Map<String,dynamic> parsedJson){
    return Attributes(
      hieght: parsedJson['height'],
      color: parsedJson['color']
    );
  }

}

class Student{
  String? name;
  int? age;
  int? rollNo;
  List<dynamic> subject;
  // this is object of class
  Attributes attribute;
 List<Images> images;
// List<Mit> mit;
  Student({
    required this.name,
    required this.age,
    required this.rollNo,
    required this.subject,
    required this.attribute,
    required this.images,
   // required this.mit,
  });
  factory Student.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['images'] as List?;
    var imagesList = list?.map((e) => Images.fromJson(e)).toList() ?? [];
   //  var list = parsedJson['images'];
   // var imagesList = list.map((e)=>Images.fromJson(e)).toList();
   //
   //  var mitList = parsedJson['Mit'] as List?;
   //  var mitObjects = mitList?.map((e) => Mit.fromJson(e)).toList();
   //  var listM = parsedJson['Mit'] as List?;
   //  var Mlist = listM?.map((e) => Mit.fromJson(e)).toList()?? [];

    return Student(
      name:  parsedJson['name'],
      age: parsedJson['age'],
      rollNo: parsedJson['rollNo'],
      subject: parsedJson['subjects'],
      attribute:Attributes.fromJson(parsedJson['attributes']) ,
     images: imagesList,
      // mit: parseMit(parsedJson['Mit'])

    );
  }
  // static List<Mit>? parseMit(mitData) {
  //   if (mitData != null && mitData is List) {
  //     var mitList = mitData.map((mit) => Mit.fromJson(mit)).toList();
  //     return mitList.isNotEmpty ? mitList : null;
  //   }
  //   return null;
  // }
}

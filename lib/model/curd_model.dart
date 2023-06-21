
class CrudModel{
 late String id;
 late String name;
 late int price;
 late String quantity;
 CrudModel({
   required this.name,
   required this.price,
   required this.quantity,
   required  this.id,
});
 CrudModel.fromJson(Map<String, dynamic> data) {
   id =data['id'];
   name = data['name'];
   price = data['price'];
   quantity = data['quantity'];
 }
 Map<String,dynamic> toJson(){
   final Map<String, dynamic> data = <String, dynamic> {};
   data['name'] = name;
   data['price'] = price;
   data['quantity'] = quantity;
   return data;
 }
 // This method directly returns a map literal containing the properties (name, price, quantity)as keys and their respective values.
// It doesn't use an intermediate variable like the first method but constructs and returns the map directly. This approach is
// suitable when the properties match the desired keys and no additional customization is required.
//1
 // Map<String, dynamic> toJson(){
 //   return {
 //     'name': name,
 //     'price':price,
 //     'quantity':quantity,
 //   };
 // }
//2
//In this method, the data map is initialized as an empty Map<String, dynamic>. Each property (question, answer, category, id) is
// then assigned to the corresponding key in the data map. The resulting map represents the object's properties with their respective
// values. This approach allows flexibility in handling specific properties and mapping them to custom keys if needed.
  // rome italy model
// Map<String,dynamic> toJson(){
//   final Map<String, dynamic> data = <String, dynamic> {};
//   data['name'] = name;
//   data['price'] = price;
//   data['quantity'] = quantity;
//   return data;
// }
//In summary, the key difference between the two methods lies in the data source they handle. fromSnapshot is used when deserializing
// data from a Firestore DocumentSnapshot, while fromJson is used when deserializing data from a generic Map<String, dynamic>
// representation.
  //1
  // factory CrudModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   final data = snapshot.data() as Map<String, dynamic>;
  //   return CrudModel(
  //     id: snapshot.id,
  //     name: data['name'],
  //     price: data['price'],
  //     quantity: data['quantity'],
  //   );
  // }
  //2
// rome italy model
  // CrudModel.fromJson(Map<String, dynamic> data) {
  //   id =data['id'];
  //   name = data['name'];
  //   price = data['price'];
  //   quantity = data['quantity'];
  //
  // }


}
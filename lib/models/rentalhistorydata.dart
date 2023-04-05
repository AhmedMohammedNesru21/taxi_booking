//RentalHistoryData


class RentalHistoryData {

  String id;
  String brand;
  String model;
  double price;
  String condition;
  List<String>? images;
  String check_in_date;
  String check_out_date;

  RentalHistoryData(
      {required this.id, required this.brand, required this.model, required this.price, required this.condition, required this.images,required this.check_in_date,required this.check_out_date});

  RentalHistoryData.toDisplay({
    required this.id,
    required this.brand,
    required this.model,
    required this.price,
    required this.condition,
    this.images,
    required this.check_in_date,
    required this.check_out_date

  });


  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "brand": brand,
      "model": model,
      "price": price,
      "condition": condition,
      "images": images,
      "check_in_date":check_in_date,
      "check_out_date":check_out_date
    };
  }
}


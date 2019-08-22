import 'package:cloud_firestore/cloud_firestore.dart';

class BoxClass {
  final String boxID;
  final String storeID;
  final String boxType;
  final Timestamp startDateTime;
  final Timestamp endDateTime;
  final double rRP;
  final String boxDescription;
  final double boxWeight;
  final String boxCharity;
  final double boxCharityPercent;
  final String imageURL;

  BoxClass(
      this.boxID,
      this.storeID,
      this.boxType,
      this.startDateTime,
      this.endDateTime,
      this.rRP,
      this.boxDescription,
      this.boxWeight,
      this.boxCharity,
      this.boxCharityPercent,
      this.imageURL);

  Map<String, dynamic> toJson() => {
        "boxID": boxID,
        "storeID": storeID,
        "boxType": boxType,
        "startDateTime": startDateTime,
        "endDateTime": endDateTime,
        "RRP": rRP,
        "boxDescription": boxDescription,
        "boxWeight": boxWeight,
        "boxCharity": boxCharity,
    "boxCharityPercent": boxCharityPercent,
    "imageURL": imageURL,
      };
}

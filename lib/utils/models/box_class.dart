class BoxClass{
  final String boxID;
  final String boxType;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final double rRP;
  final String boxDescription;
  final double boxWeight;
  final String boxCharity;
  final double boxCharityPercent;

  BoxClass(this.boxID, this.boxType, this.startDate, this.startTime, this.endDate, this.endTime, this.rRP, this.boxDescription, this.boxWeight, this.boxCharity, this.boxCharityPercent);

Map<String, dynamic> toJson()=>{

    "boxID": boxID,
    "boxType": boxType,
    "startDate": startDate,
    "startTime": startTime,
    "endDate": endDate,
    "endTime": endTime,
    "RRP": rRP,
    "boxDescription": boxDescription,
    "boxWeight": boxWeight,
    "boxCharity": boxCharity,
    "boxCharityPercent": boxCharityPercent
};

}
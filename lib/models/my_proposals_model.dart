import 'dart:convert';

MyProposalsModel myOffersModelFromJson(String str) =>
    MyProposalsModel.fromJson(json.decode(str));

String myOffersModelToJson(MyProposalsModel data) => json.encode(data.toJson());

class MyProposalsModel {
  MyProposals? myProposals;

  MyProposalsModel({
    this.myProposals,
  });

  factory MyProposalsModel.fromJson(Map json) => MyProposalsModel(
        myProposals: json["my_proposals"] == null
            ? null
            : MyProposals.fromJson(json["my_proposals"]),
      );

  Map<String, dynamic> toJson() => {
        "my_proposals": myProposals?.toJson(),
      };
}

class MyProposals {
  List<Proposal>? data;
  dynamic nextPageUrl;
  dynamic path;

  MyProposals({
    this.data,
    this.nextPageUrl,
    this.path,
  });

  factory MyProposals.fromJson(Map<String, dynamic> json) => MyProposals(
        data: json["data"] == null
            ? []
            : List<Proposal>.from(
                json["data"]!.map((x) => Proposal.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Proposal {
  dynamic id;
  dynamic jobId;
  dynamic freelancerId;
  dynamic clientId;
  num? amount;
  String? duration;
  dynamic revision;
  String? coverLetter;
  String? attachment;
  dynamic status;
  dynamic isHired;
  dynamic isShortListed;
  dynamic isInterviewTake;
  dynamic isView;
  dynamic isRejected;
  DateTime? createdAt;
  DateTime? updatedAt;
  Job? job;

  Proposal({
    this.id,
    this.jobId,
    this.freelancerId,
    this.clientId,
    this.amount,
    this.duration,
    this.revision,
    this.coverLetter,
    this.attachment,
    this.status,
    this.isHired,
    this.isShortListed,
    this.isInterviewTake,
    this.isView,
    this.isRejected,
    this.createdAt,
    this.updatedAt,
    this.job,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        jobId: json["job_id"],
        freelancerId: json["freelancer_id"],
        clientId: json["client_id"],
        amount: num.tryParse(json["amount"].toString()) ?? 0,
        duration: json["duration"],
        revision: json["revision"],
        coverLetter: json["cover_letter"],
        attachment: json["attachment"],
        status: json["status"],
        isHired: json["is_hired"].toString() == "1",
        isShortListed: json["is_short_listed"].toString() == "1",
        isInterviewTake: json["is_interview_take"].toString() == "1",
        isView: json["is_view"].toString() == "1",
        isRejected: json["is_rejected"].toString() == "1",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"]),
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "freelancer_id": freelancerId,
        "client_id": clientId,
        "amount": amount,
        "duration": duration,
        "revision": revision,
        "cover_letter": coverLetter,
        "attachment": attachment,
        "status": status,
        "is_hired": isHired,
        "is_short_listed": isShortListed,
        "is_interview_take": isInterviewTake,
        "is_view": isView,
        "is_rejected": isRejected,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "job": job?.toJson(),
      };
}

class Job {
  dynamic id;
  dynamic userId;
  String? title;
  dynamic budget;

  Job({
    this.id,
    this.userId,
    this.title,
    this.budget,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        budget: json["budget"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "budget": budget,
      };
}

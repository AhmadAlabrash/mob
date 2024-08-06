import 'dart:convert';

JobListModel jobListModelFromJson(String str) =>
    JobListModel.fromJson(json.decode(str));

String jobListModelToJson(JobListModel data) => json.encode(data.toJson());

class JobListModel {
  Jobs? jobs;

  JobListModel({
    this.jobs,
  });

  factory JobListModel.fromJson(Map json) => JobListModel(
        jobs: json["all_jobs"] == null ? null : Jobs.fromJson(json["all_jobs"]),
      );

  Map<String, dynamic> toJson() => {
        "all_jobs": jobs?.toJson(),
      };
}

class Jobs {
  List<Job>? job;
  dynamic nextPageUrl;
  String? path;

  Jobs({
    this.job,
    this.nextPageUrl,
    this.path,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
        job: json["data"] == null
            ? []
            : List<Job>.from(json["data"]!.map((x) => Job.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "job":
            job == null ? [] : List<dynamic>.from(job!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
      };
}

class Job {
  dynamic id;
  dynamic userId;
  String? title;
  String? slug;
  dynamic category;
  String? duration;
  String? level;
  String? description;
  String? type;
  int? budget;
  String? attachment;
  dynamic status;
  dynamic currentStatus;
  dynamic onOff;
  dynamic jobApproveRequest;
  DateTime? lastSeen;
  dynamic lastApplyDate;
  num? jobProposalCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  JobCreator? jobCreator;
  List<JobSkill>? jobSkills;

  Job({
    this.id,
    this.userId,
    this.title,
    this.slug,
    this.category,
    this.duration,
    this.level,
    this.description,
    this.type,
    this.budget,
    this.attachment,
    this.status,
    this.currentStatus,
    this.onOff,
    this.jobProposalCount,
    this.jobApproveRequest,
    this.lastSeen,
    this.lastApplyDate,
    this.createdAt,
    this.updatedAt,
    this.jobCreator,
    this.jobSkills,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        slug: json["slug"],
        category: json["category"],
        duration: json["duration"],
        level: json["level"],
        description: json["description"],
        jobProposalCount: json["job_proposals_count"] is String
            ? num.tryParse(json["job_proposals_count"])
            : json["job_proposals_count"],
        type: json["type"],
        budget: json["budget"],
        attachment: json["attachment"],
        status: json["status"],
        currentStatus: json["current_status"],
        onOff: json["on_off"],
        jobApproveRequest: json["job_approve_request"],
        lastSeen: json["last_seen"] == null
            ? null
            : DateTime.parse(json["last_seen"]),
        lastApplyDate: json["last_apply_date"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        jobCreator: json["job_creator"] == null
            ? null
            : JobCreator.fromJson(json["job_creator"]),
        jobSkills: json["job_skills"] == null
            ? []
            : List<JobSkill>.from(
                json["job_skills"]!.map((x) => JobSkill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "slug": slug,
        "category": category,
        "duration": duration,
        "level": level,
        "description": description,
        "type": type,
        "budget": budget,
        "attachment": attachment,
        "status": status,
        "current_status": currentStatus,
        "on_off": onOff,
        "job_approve_request": jobApproveRequest,
        "last_seen": lastSeen?.toIso8601String(),
        "last_apply_date": lastApplyDate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "job_creator": jobCreator?.toJson(),
        "job_skills": jobSkills == null
            ? []
            : List<dynamic>.from(jobSkills!.map((x) => x.toJson())),
      };
}

class JobCreator {
  dynamic id;
  String? firstName;
  String? lastName;
  dynamic hourlyRate;
  String? experienceLevel;
  String? email;
  String? phone;
  String? username;
  String? image;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic userType;
  DateTime? checkOnlineStatus;
  dynamic checkWorkAvailability;
  dynamic userActiveInactiveStatus;
  bool userVerifiedStatus;

  dynamic isSuspend;
  dynamic termsCondition;
  dynamic about;
  String? isEmailVerified;
  String? google2FaSecret;
  dynamic google2FaEnableDisableDisable;
  dynamic googleId;
  dynamic facebookId;
  dynamic githubId;
  String? emailVerifyToken;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  UserCountry? userCountry;

  JobCreator({
    this.id,
    this.firstName,
    this.lastName,
    this.hourlyRate,
    this.experienceLevel,
    this.email,
    this.phone,
    this.username,
    this.image,
    this.countryId,
    this.stateId,
    this.cityId,
    this.userType,
    this.checkOnlineStatus,
    this.checkWorkAvailability,
    this.userActiveInactiveStatus,
    required this.userVerifiedStatus,
    this.isSuspend,
    this.termsCondition,
    this.about,
    this.isEmailVerified,
    this.google2FaSecret,
    this.google2FaEnableDisableDisable,
    this.googleId,
    this.facebookId,
    this.githubId,
    this.emailVerifyToken,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userCountry,
  });

  factory JobCreator.fromJson(Map<String, dynamic> json) => JobCreator(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        hourlyRate: json["hourly_rate"],
        experienceLevel: json["experience_level"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        image: json["image"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        userType: json["user_type"],
        checkOnlineStatus: json["check_online_status"] == null
            ? null
            : DateTime.parse(json["check_online_status"]),
        checkWorkAvailability: json["check_work_availability"],
        userActiveInactiveStatus: json["user_active_inactive_status"],
        userVerifiedStatus: json["user_verified_status"].toString() == "1",
        isSuspend: json["is_suspend"],
        termsCondition: json["terms_condition"],
        about: json["about"],
        isEmailVerified: json["is_email_verified"],
        google2FaSecret: json["google_2fa_secret"],
        google2FaEnableDisableDisable:
            json["google_2fa_enable_disable_disable"],
        googleId: json["google_id"],
        facebookId: json["facebook_id"],
        githubId: json["github_id"],
        emailVerifyToken: json["email_verify_token"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        userCountry: json["user_country"] == null
            ? null
            : UserCountry.fromJson(json["user_country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "hourly_rate": hourlyRate,
        "experience_level": experienceLevel,
        "email": email,
        "phone": phone,
        "username": username,
        "image": image,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "user_type": userType,
        "check_online_status": checkOnlineStatus?.toIso8601String(),
        "check_work_availability": checkWorkAvailability,
        "user_active_inactive_status": userActiveInactiveStatus,
        "user_verified_status": userVerifiedStatus,
        "is_suspend": isSuspend,
        "terms_condition": termsCondition,
        "about": about,
        "is_email_verified": isEmailVerified,
        "google_2fa_secret": google2FaSecret,
        "google_2fa_enable_disable_disable": google2FaEnableDisableDisable,
        "google_id": googleId,
        "facebook_id": facebookId,
        "github_id": githubId,
        "email_verify_token": emailVerifyToken,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class UserCountry {
  dynamic id;
  String? country;
  dynamic status;

  UserCountry({
    this.id,
    this.country,
    this.status,
  });

  factory UserCountry.fromJson(Map<String, dynamic> json) => UserCountry(
        id: json["id"],
        country: json["country"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "status": status,
      };
}

class JobSkill {
  dynamic id;
  String? skill;
  String? categoryId;
  String? subCategoryId;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  JobSkill({
    this.id,
    this.skill,
    this.categoryId,
    this.subCategoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory JobSkill.fromJson(Map<String, dynamic> json) => JobSkill(
        id: json["id"],
        skill: json["skill"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skill": skill,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  dynamic jobPostId;
  dynamic skillId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pivot({
    this.jobPostId,
    this.skillId,
    this.createdAt,
    this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        jobPostId: json["job_post_id"],
        skillId: json["skill_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "job_post_id": jobPostId,
        "skill_id": skillId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

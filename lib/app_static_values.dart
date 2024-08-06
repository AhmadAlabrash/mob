import 'package:xilancer/helper/local_keys.g.dart';

List<String> experienceLevels = [
  "senior",
  "midLevel",
  "junior",
];
List<String> jobType = [
  "senior",
  "midLevel",
  "junior",
  "not mandatory",
];

List<String> jobLengths = [
  "1 Days",
  "2 Days",
  "3 Days",
  "less than a week",
  "less than a month",
  "less than 2 month",
  "less than 3 month",
  "More than 3 month",
];

List<String> supportedFileTypesInC = [
  "png",
  "jpg",
  "jpeg",
  "pdf",
  "gif",
];

List<String> offerStatus = [
  LocalKeys.pending,
  LocalKeys.accepted,
  LocalKeys.declined
];

enum Status {
  LOADING,
  NOT_INITIATED,
  NOT_AVAILABLE,
  INVALID,
  AVAILABLE,
}

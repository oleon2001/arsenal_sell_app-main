import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_queue.freezed.dart';
part 'email_queue.g.dart';

@freezed
class EmailQueue with _$EmailQueue {
  const factory EmailQueue({
    required int id,
    required String toEmail,
    required String subject,
    required String body,
    DateTime? createdAt,
    DateTime? sentAt,
  }) = _EmailQueue;

  factory EmailQueue.fromJson(Map<String, dynamic> json) =>
      _$EmailQueueFromJson(json);
}

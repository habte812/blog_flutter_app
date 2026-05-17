import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_reply_notifier.g.dart';

@riverpod
class ActiveReplyNotifier extends _$ActiveReplyNotifier {
  @override
  ReplyState build() => ReplyState(parentId: null, replyingToName: null);
  void setReply(int parentID, String name) {
    state = ReplyState(parentId: parentID, replyingToName: name);
  }

  void cancelReply() {
    state = ReplyState(parentId: null, replyingToName: null);
  }
}

class ReplyState {
  final int? parentId;
  final String? replyingToName;
  ReplyState({this.parentId, this.replyingToName});
}

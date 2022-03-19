import 'package:flutter/material.dart';
import 'package:minimize_with_overlay/dto/video_list_item_dto.dart';

class AppStateModel extends ChangeNotifier {
  bool _isOverlayPlayerAdded = false;
  bool _isVideoStarted = false;
  bool _isVideoMinimized = false;
  final List<OverlayEntry> _overlayEntryList = [];
  VideoListItemDTO? _activeVideoListItem;

  bool get isOverlayPlayerAdded => _isOverlayPlayerAdded;

  bool get isVideoStarted => _isVideoStarted;

  bool get isVideoMinimized => _isVideoMinimized;

  VideoListItemDTO? get activeVideoListItem => _activeVideoListItem;

  void setIsOverlayPlayerAdded(bool flag) {
    _isOverlayPlayerAdded = flag;
    notifyListeners();
  }

  void setIsVideoStarted(
      {required bool flag, VideoListItemDTO? videoListItem}) {
    _isVideoStarted = flag;
    if (isVideoStarted) {
      _activeVideoListItem = videoListItem;
    } else {
      _activeVideoListItem = null;
      _isVideoMinimized = false;
    }
    notifyListeners();
  }

  void setIsVideoMinimized(bool isVideoMinimized) {
    _isVideoMinimized = isVideoMinimized;
    notifyListeners();
  }

  void addToOverlayEntry({required OverlayEntry overlayEntry}) {
    if (!_overlayEntryList.contains(overlayEntry)) {
      _overlayEntryList.add(overlayEntry);
    }
  }

  void popOverlayEntry() {
    if (_overlayEntryList.length > 1) {
      _overlayEntryList.last.remove();
      _overlayEntryList.removeLast();
    }
  }
}
